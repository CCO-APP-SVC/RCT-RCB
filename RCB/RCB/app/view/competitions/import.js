Ext.define('BR.view.competitions.import', {
  extend: 'Ext.Window',
  alias: 'widget.importComp',
  title: BR.lang.btn.imp,
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
            itemId: 'csv',
            xtype: 'textarea',
            height: '100%',
            rows: '10',
            blankText: BR.lang.login.blankError,
            name: 'csv',
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
      defaultFocus: 'csv'
    });
    this.callParent(arguments);
  }
});
