#include "fabm_driver.h"
module ersem_nitrogen_depos

   use fabm_types
   use ersem_shared

   implicit none

   private

   type,extends(type_base_model),public :: type_ersem_nitrogen_depos
      type (type_state_variable_id)     :: id_N3n
      type (type_dependency_id)         :: id_ETW, id_X1X
      type (type_horizontal_dependency_id) :: id_wnd

      type (type_horizontal_diagnostic_variable_id) ::  id_airn

      integer :: iswDEPX
      real(rk):: DEP_rateX
   contains
      procedure :: initialize
      procedure :: do_surface
   end type

contains

   subroutine initialize(self,configunit)
      class (type_ersem_nitrogen_depos), intent(inout), target :: self
      integer,                       intent(in)            :: configunit

      call self%get_parameter(self%iswDEPX,'iswDEP','','Air deposition (1: True, 2: False)')
      call self%get_parameter(self%DEP_rateX,'DEP_rate','','deposition rate')

      call self%register_state_variable(self%id_N3n,'o','mmol N/m^3','nitrate', 300._rk)

      call self%register_diagnostic_variable(self%id_airn,'airn','mmolN/m^2/d','N deposition flux', source=source_do_surface)

      call self%register_dependency(self%id_ETW,standard_variables%temperature)
      call self%register_dependency(self%id_X1X,standard_variables%practical_salinity)
      call self%register_dependency(self%id_wnd,standard_variables%wind_speed)


   end subroutine

   subroutine do_surface(self,_ARGUMENTS_DO_SURFACE_)
      class (type_ersem_nitrogen_depos), intent(in) :: self
      _DECLARE_ARGUMENTS_DO_SURFACE_

      real(rk) :: N3n, ETW, T, X1X, wnd
      real(rk) :: AIRN,DEP_rateX

      _HORIZONTAL_LOOP_BEGIN_
         _GET_(self%id_N3n, N3n)
         _GET_(self%id_ETW, ETW)
         _GET_(self%id_X1X, X1X)
         _GET_HORIZONTAL_(self%id_wnd, wnd)

         wnd = max(wnd, 0.0_rk)

         if (self%iswDEPX == 1) then   ! do deposition
            AIRN = wnd * DEP_rateX
         elseif (self%iswDEPX == 2) then   ! without deposition
            AIRN = 0
         endif

         ! units of ko2 converted from /hr to /day
         AIRN = AIRN * (24._rk)

         _SET_SURFACE_EXCHANGE_(self%id_N3n, AIRN)
         _SET_HORIZONTAL_DIAGNOSTIC_(self%id_airn, AIRN)
      _HORIZONTAL_LOOP_END_
   end subroutine

end module


