Ext.define('BR.view.competitions.add', {
  extend: 'Ext.Window',
  alias: 'widget.addComp',
  title: BR.lang.comp.addTitle,
  width: 400,
  height: 215,
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
            itemId: 'title-fr',
            xtype: 'textfield',
            blankText: BR.lang.login.blankError,
            fieldLabel: BR.lang.comp.frTitle,
            name: 'title-fr',
            allowBlank: false,
            anchor: '100%',
            selectOnFocus: true
          },{
            xtype: 'textfield',
            blankText: BR.lang.login.blankError,
            fieldLabel: BR.lang.comp.enTitle,
            name: 'title-en',
            allowBlank: false,
            anchor: '100%',
            selectOnFocus: true
          },{
            xtype: 'combo',
            itemId: 'type',
            blankText: BR.lang.login.blankError,
            fieldLabel: BR.lang.comp.type,
            name: 'type',
            allowBlank: false,
            anchor: '100%',
            store: Ext.create( 'BR.store.Types' ),
            selectOnFocus: true,
            queryMode: 'local',
            displayField: 'name',
            valueField: 'type'
          },{
            xtype: 'checkbox',
            fieldLabel: BR.lang.comp.showFinal,
            name: 'showFinal',
            inputValue: '1',
            id: 'showFinal'
          },{
            xtype: 'hidden',
            name: 'form-action'
          },{
            xtype: 'hidden',
            name: 'cid'
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
      defaultFocus: 'title-fr'
    });
    this.callParent(arguments);
  }
});
