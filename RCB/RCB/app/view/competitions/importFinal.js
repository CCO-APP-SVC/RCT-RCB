Ext.define('BR.view.competitions.importFinal', {
  extend: 'Ext.Window',
  alias: 'widget.importCompFinal',
  title: BR.lang.btn.impFinal,
  width: 400,
  height: 250,
  closable: true,
  resizable: false,
  draggable: false,
  autoHeight: true,
  layout: 'fit',
  border: false,
  modal: true,
  initComponent: function() {
    Ext.apply(this, {
      items: [{
        xtype: 'form',
        plain: true,
        frame: true,
        border: 0,
        flex: 1,
        bodyPadding: 15,
        items: [{
            itemId: 'finalHtml',
            xtype: 'textarea',
            height: '100%',
            rows: '10',
            blankText: BR.lang.login.blankError,
            name: 'finalHtml',
            allowBlank: false,
            anchor: '100%',
            selectOnFocus: true
          }]
      }],
      buttons: [{
	  text: BR.lang.btn.validate,
	  action: "validate"
      },{
        text: BR.lang.btn.cancel,
	scope: this,
	handler: this.close
      }],
      defaultFocus: 'finalHtml'
    });
    this.callParent(arguments);
  }
});
