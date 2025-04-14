#include "fabm_driver.h"

!------------------------------------------------------------------------
! This module calculates saturation concentrations and air-sea
! exchange of methane.
!------------------------------------------------------------------------

module ersem_methane

   use fabm_types
   use fabm_particle

   use ersem_shared
   use ersem_pelagic_base

   implicit none

   private

   type,extends(type_ersem_pelagic_base),public :: type_ersem_methane
      ! Variables
      type (type_dependency_id)                     :: id_ETW,id_X1X
      type (type_state_variable_id)                 :: id_Z4c,id_Z5c,id_Z6c,id_O3c,id_O2o
      type (type_horizontal_dependency_id)          :: id_wnd,id_pCH4a,id_seaice
      type (type_horizontal_diagnostic_variable_id) :: id_fair
      type (type_diagnostic_variable_id)            :: id_sat,id_satp,id_consumption,id_transport,id_zooprod
      ! Parameters
      integer :: iswCH4,iswZCH4,iswSCH4
      !real(rk)    :: mox
      real (rk) :: kch4, kzch4, frCH4, refS

   contains
!     Model procedures
      procedure :: initialize
      procedure :: do_surface
      procedure :: do
   end type

contains

   subroutine initialize(self,configunit)
!
! !DESCRIPTION:
!
! !INPUT PARAMETERS:
      class (type_ersem_methane),      intent(inout),target :: self
      integer,                         intent(in)           :: configunit
!
!EOP
!-----------------------------------------------------------------------
!BOC
      call self%initialize_ersem_base(sedimentation=.false.)

      call self%add_constituent('c',0.0_rk)

      !call self%register_state_dependency(self%id_B1c,'B1c','mg C/m^3','bacteria mass')
      call self%register_state_dependency(self%id_Z4c,'Z4c','mg C/m^3','mesozoo mass')
      call self%register_state_dependency(self%id_Z5c,'Z5c','mg C/m^3','microzoo mass')
      call self%register_state_dependency(self%id_Z6c,'Z6c','mg C/m^3','HNF mass')

      call self%register_state_dependency(self%id_O3c,'O3c','mmol C/m^3','carbon dioxide')
      call self%register_state_dependency(self%id_O2o,'O2o','mmol O_2/m^3','oxygen source')

      call self%register_dependency(self%id_ETW,standard_variables%temperature)
      call self%register_dependency(self%id_X1X,standard_variables%practical_salinity)
      call self%register_dependency(self%id_wnd,standard_variables%wind_speed)
      call self%register_dependency(self%id_seaice,standard_variables%ice_area_fraction)
      call self%register_dependency(self%id_pCH4a,partial_pressure_of_ch4)
      call self%register_diagnostic_variable(self%id_sat,'sat','mmol CH4/m3','methane saturation conc')
      call self%register_diagnostic_variable(self%id_satp,'satp','%','methane % saturation')
      call self%register_diagnostic_variable(self%id_fair,'fair','mmol CH4/m^2/d','air-sea flux of CH4',source=source_do_surface)
      call self%register_diagnostic_variable(self%id_consumption,'consumption','umol C/m^3/d','methane consumption rate')
      call self%register_diagnostic_variable(self%id_transport,'transport','umol C/m^3/d','methane transport rate')
      call self%register_diagnostic_variable(self%id_zooprod,'zooprod','mg C/m^3/d','methane zooprod rate')

      call self%get_parameter(self%iswCH4,'iswCH4','','air-sea flux switch (0: off, 1: on)',default=1)
      call self%get_parameter(self%iswZCH4,'iswZCH4','','Zooplankton mediated production switch (0: off, 1: on)',default=1)
      call self%get_parameter(self%iswSCH4,'iswSCH4','','Lateral transport switch (0: off, 1: on)',default=1)
      call self%get_parameter(self%kch4,'kch4','m^3/umol C/d','biological oxidation rate specfic per unit of bacteria biomass')
      call self%get_parameter(self%kzch4,'kzch4','m^3/umol C/d','Methanogenesis per unit of zooplankton biomass')
      call self%get_parameter(self%refS,'refS','','reference salinity of freshwater')
      call self%get_parameter(self%frCH4,'frCH4','mg C m-3 d-1','reference salinity of freshwater')

   end subroutine initialize

   subroutine do(self,_ARGUMENTS_DO_)
      class (type_ersem_methane), intent(in) :: self
      _DECLARE_ARGUMENTS_DO_

      real(rk) :: CH4c,ETW,X1X
      real(rk) :: CH4sat,pCH4a
      real(rk) :: Mch4,Zch4,Sch4
      real(rk) :: O3c,Z4c,Z5c,Z6c

       _LOOP_BEGIN_
          _GET_(self%id_c,CH4c)
          _GET_(self%id_O3c,O3c)
          _GET_(self%id_Z4c,Z4c)
          _GET_(self%id_Z5c,Z5c)
          _GET_(self%id_Z6c,Z6c)
          _GET_(self%id_ETW,ETW)
          _GET_(self%id_X1X,X1X)
          _GET_HORIZONTAL_(self%id_pCH4a,pCH4a)
   
        !_SET_ODE_(self%id_c,-self%mox * CH4c)

         CH4sat = ch4_saturation_concentration(self,ETW,X1X,pCH4a)
         _SET_DIAGNOSTIC_(self%id_sat,CH4sat)     !mmol C m-3
         _SET_DIAGNOSTIC_(self%id_satp,(100._rk*(CH4c/12.01/CH4sat)))

         ! consumption rate in mg/m^3/day
         Mch4 = self%kch4*CH4c    !*B1c

         _SET_DIAGNOSTIC_(self%id_consumption,Mch4)
         _SET_ODE_ (self%id_c, -Mch4)
         _SET_ODE_ (self%id_O3c, Mch4/12.01)
         _SET_ODE_ (self%id_O2o, -Mch4/12.01*2)

 
         ! Zooplankton-Mediated Methane Production
         if (self%iswZCH4 .eq. 1) then
           Zch4 = (Z4c + Z5c + Z6c) * self%kzch4 
           _SET_DIAGNOSTIC_(self%id_zooprod,Zch4)
           _SET_ODE_ (self%id_c, Zch4)
           _SET_ODE_ (self%id_Z4c, -Zch4/3)
           _SET_ODE_ (self%id_Z5c, -Zch4/3)
           _SET_ODE_ (self%id_Z6c, -Zch4/3)
         end if

         ! Lateral transport of Methane depending on the salinity difference
         if (self%iswSCH4 .eq. 1) then
           if (X1X < self%refS) then
             SCH4= (self%refS - X1X) * self%frCH4
             _SET_DIAGNOSTIC_(self%id_transport,Sch4)
             _SET_ODE_(self%id_c,SCH4)
           end if
         end if

      _LOOP_END_
   end subroutine

   subroutine do_surface(self,_ARGUMENTS_DO_SURFACE_)
      class (type_ersem_methane), intent(in) :: self
      _DECLARE_ARGUMENTS_DO_SURFACE_

      real(rk) :: CH4c,ETW,X1X,wnd, fwind, seaice
      real(rk) :: CH4sat,sc,ch4flux,pCH4a

      _HORIZONTAL_LOOP_BEGIN_
         _GET_(self%id_c,CH4c)
         _GET_(self%id_ETW,ETW)
         _GET_(self%id_X1X,X1X)
         _GET_HORIZONTAL_(self%id_wnd,wnd)
         _GET_HORIZONTAL_(self%id_seaice,seaice)
         _GET_HORIZONTAL_(self%id_pCH4a,pCH4a)

! Schmidt number for CH4 (Wanninkhof, 2014)
 
        sc=2101.2_rk-131.54_rk*ETW+4.4931_rk*ETW**2._rk-0.08676_rk*ETW**3._rk+0.00070663_rk*ETW**4._rk
        fwind =  0.251_rk * wnd**2._rk *(sc/660._rk)**(-0.5_rk)
        fwind=fwind*24._rk/100._rk  ! convert to m/day

        CH4sat = ch4_saturation_concentration(self,ETW,X1X,pCH4a)

        if (self%iswCH4 .eq. 1) then
         ch4flux = fwind*(CH4sat - CH4c/12.01) * (1-seaice)
        else
         ch4flux=0._rk
        endif

         _SET_HORIZONTAL_DIAGNOSTIC_(self%id_fair,ch4flux)

         _SET_SURFACE_EXCHANGE_(self%id_c,ch4flux*12.01)

      _HORIZONTAL_LOOP_END_
   end subroutine do_surface

   function ch4_saturation_concentration(self,ETW,X1X,pCH4a) result(CH4sat)
       class (type_ersem_methane), intent(in) :: self
       real(rk),                         intent(in) :: ETW,X1X,pCH4a
       real(rk)                                     :: CH4sat
       real(rk)           :: tk,tk100

! Coefficients for temperature and salinity dependence of methane solubility 
! according to Wiesenburg and Guinasso (1979)

       real(rk),parameter :: A1 = -415.2807_rk  !-68.8862_rk
       real(rk),parameter :: A2 = 596.8104_rk   !101.4956_rk
       real(rk),parameter :: A3 = 379.2599_rk   !28.7314_rk
       real(rk),parameter :: A4 = -62.0757_rk
       real(rk),parameter :: B1 = -0.059160_rk  !-0.076146_rk
       real(rk),parameter :: B2 = 0.032174_rk   !0.043970_rk
       real(rk),parameter :: B3 = -0.0048198_rk !-0.006872_rk

       TK=ETW+273.15_rk
       TK100=TK/100._rk

        CH4sat = exp(A1+A2/tk100 + A3 * log(tk100) + A4 * tk100 + &
        &       X1X * (B1 + B2 * tk100 + B3 * tk100 ** 2._rk))
        
!        pCH4a is given in uatm, so it is here converted to atm  by means of a 1.-6 factor.
!        To convert umol/m3 to mmol/m3 we divide it by 1000.

        CH4sat = CH4sat * pCH4a * 1.e-6_rk
        
        CH4sat = CH4sat / 1000.
        
    end function
   
end module
