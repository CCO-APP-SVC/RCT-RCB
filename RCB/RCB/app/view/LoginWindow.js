Ext.define('BR.view.LoginWindow', {
  extend: 'Ext.Window',
  alias: 'widget.loginwindow',
  title: BR.lang.login.title,
  width: 400,
  height: 150,
  closable: false,
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
            itemId: 'username',
            xtype: 'textfield',
            blankText: BR.lang.login.blankError,
            fieldLabel: BR.lang.login.username,
            name: 'username',
            allowBlank: false,
            anchor: '100%',
            selectOnFocus: true
          },{
            xtype: 'textfield',
            blankText: BR.lang.login.blankError,
            fieldLabel: BR.lang.login.password,
            name: 'password',
            allowBlank: false,
            inputType: 'password',
            anchor: '100%',
            selectOnFocus: true
          }]
      }]
    });
    this.callParent(arguments);
  },
  buttons: [{
      text: BR.lang.login.button,
      type: "submit",
      action: "login",
      formBind: true
    }],
  defaultFocus: 'userName'
});
