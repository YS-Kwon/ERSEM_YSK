#include "fabm_driver.h"

module fabm_library
   use fabm_types, only: type_base_model_factory, type_base_model

   use fabm_builtin_models

   ! Auto-generated references to institute-specific modules with model libraries:
   use akvaplan_model_library
   use au_model_library
   use bb_model_library
   use csiro_model_library
   use ersem_model_library
   use examples_model_library
   use gotm_model_library
   use iow_model_library
   use jrc_model_library
   use msi_model_library
   use nersc_model_library
   use niva_model_library
   use pml_model_library
   use selma_model_library
   use su_model_library
   use uhh_model_library

   implicit none

   private

   type, extends(type_base_model_factory) :: type_factory
      contains
      procedure :: create
      procedure :: initialize
   end type

   type (type_factory), save, target, public :: fabm_model_factory

contains

   subroutine initialize(self)
      class (type_factory), intent(inout) :: self

      ! Auto-generated registration of institute-specific model libraries:
      call self%add(akvaplan_model_factory, 'akvaplan')
      call self%add(au_model_factory, 'au')
      call self%add(bb_model_factory, 'bb')
      call self%add(csiro_model_factory, 'csiro')
      call self%add(ersem_model_factory, 'ersem')
      call self%add(examples_model_factory, 'examples')
      call self%add(gotm_model_factory, 'gotm')
      call self%add(iow_model_factory, 'iow')
      call self%add(jrc_model_factory, 'jrc')
      call self%add(msi_model_factory, 'msi')
      call self%add(nersc_model_factory, 'nersc')
      call self%add(niva_model_factory, 'niva')
      call self%add(pml_model_factory, 'pml')
      call self%add(selma_model_factory, 'selma')
      call self%add(su_model_factory, 'su')
      call self%add(uhh_model_factory, 'uhh')

      call self%add(builtin_factory)

      ! Go through default initializaton steps.
      ! This also allows new added child model factories to initialize.
      call self%type_base_model_factory%initialize()
   end subroutine initialize

   subroutine create(self, name, model)
      class (type_factory), intent(in) :: self
      character(*),         intent(in) :: name
      class (type_base_model), pointer :: model

      model => null()

      call self%type_base_model_factory%create(name,model)

      ! Store name that was used to create this model, so we can re-create it in the future.
      if (associated(model)) model%type_name = name
   end subroutine create

end module fabm_library

!-----------------------------------------------------------------------
! Copyright by the FABM team under the GNU Public License - www.gnu.org
!-----------------------------------------------------------------------
