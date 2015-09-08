describe('Modal Controller', function(){
    var ctrl, $Modal, $ModalService
    
    var id = 1;

    beforeEach(inject(function($controller, Modal, ModalService){
      $Modal        = Modal;
      $ModalService = ModalService;
      spyOn($ModalService, "registerModalController");
      $ =  function() {return {modal: function(){}}};
      ctrl = $controller('ModalController', 
          {
            ModalService: $ModalService,
            Modal: Modal
          });
    }));
    
    it("Should register callback", function(){
       expect($ModalService.registerModalController).toHaveBeenCalled();
    });
    
    it("Should show modal", function(){
       
       ctrl.showModal("abc");
       expect(ctrl.modal).toBe("abc");
    });
    
});

