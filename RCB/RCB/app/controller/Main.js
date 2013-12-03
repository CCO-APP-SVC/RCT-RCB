Ext.define('BR.controller.Main', {
    extend: 'Ext.app.Controller',

    refs: [{ ref: 'loginwindow', selector: 'LoginWindow' },
           { ref: 'contentArea', selector: 'ContentArea' }], 

    init: function() {
        var me = this;
        this.control({
            'loginwindow button[action=login]': {
                click: this.login
            },
            'loginwindow textfield': { 
                specialkey: function(field, e) { 
                    if(e.getKey() == e.ENTER) {
                       me.login( field.up('window').down('button[action=login]') );
                    } 
                } 
            } 
        });
    },

    views: ['LoginWindow', 'ContentArea'],   

    login: function(button) {
	    var win    = button.up('window'),
	        form   = win.down('form'),
	        values = form.getValues();
            Ext.Ajax.request({
                url: 'services/login.aspx',
                params: values,
                success: function(response){
                    var text = response.responseText;
                    if( text ) {
                         window.location.reload();
                        /*Ext.create('Ext.container.Viewport', {
                            layout: 'fit',
                            items: [
                                {xtype: 'contentArea'}
                            ]
                        });
                        Ext.get('body').unmask();
                        Ext.get('loginAs').update( BR.lang.connectedAs + 
                                                   '<b>'+text+'</b> : <a href="#" id="disconnect">'
                                                   + BR.lang.logout +'</a>' );
                        BR.applyLogoutListener();
                        win.destroy();*/
                    } else {
                        Ext.Msg.show({
                             title: BR.lang.login.badloginTitle,
                             msg:  BR.lang.login.badloginMess,
                             buttons: Ext.Msg.OK,
                             icon: Ext.Msg.ERROR
                        });
                    }
                },
                failure: function(response){
                   // Do something
                }
            });
    }
});
