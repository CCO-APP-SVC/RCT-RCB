Ext.define('BR.view.events.add', {
  extend: 'Ext.Window',
  alias: 'widget.addEvent',
  title: BR.lang.event.addTitle,
  width: 400,
  height: 150,
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
            itemId: 'name-fr',
            xtype: 'textfield',
            blankText: BR.lang.login.blankError,
            fieldLabel: BR.lang.event.frName,
            name: 'name-fr',
            allowBlank: false,
            anchor: '100%',
            selectOnFocus: true
          },{
            xtype: 'textfield',
            blankText: BR.lang.login.blankError,
            fieldLabel: BR.lang.event.enName,
            name: 'name-en',
            allowBlank: false,
            anchor: '100%',
            selectOnFocus: true
          },{
            xtype: 'hidden',
            name: 'form-action'
          },{
            xtype: 'hidden',
            name: 'eid'
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
      defaultFocus: 'name-fr'
    });
    this.callParent(arguments);
  }
});
