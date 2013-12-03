// Mandadory to load dependencies dynamically
Ext.Loader.setConfig({ enabled:true });

// Main application file
Ext.application({

    // Namespace
    name: 'BR',

    // Will launch viewport when needed
    autoCreateViewport: false,

    // Load controllers
    controllers: ['Main','Events'],

    // Main function
    launch: function() {

        // Will show something later (Authentification page or viewport)
        Ext.get('body').mask( BR.lang.loading );

        // Handle 403 HTTP status
        Ext.Ajax.on('requestexception', function (conn, response, options) {
            if (response.status === 403) {
                Ext.create('BR.view.LoginWindow', {}).show();
                Ext.get('body').unmask();
            }
        });

        // Validate login and retrieve user info
        var userProfile = Ext.create( 'BR.store.UserProfile' );
        userProfile.load( function( records, operation, success ) {
            if( success ) {
                // Time to launch viewport !
               // Ext.require('BR.locale.fr');
                Ext.create('Ext.container.Viewport', {
                    layout: 'fit',
                    items: [
                        {xtype: 'contentArea'}
                    ]
                });

                Ext.get('body').unmask();
                Ext.get('loginAs').update( BR.lang.connectedAs + '<b>'+userProfile.data.keys[0] +
                                           '</b> : <a href="#" id="disconnect">'+ BR.lang.logout +'</a>');
                BR.applyLogoutListener();
            }
        });

    }
});

// Handle logout link
Ext.namespace('BR').applyLogoutListener = function() {
    Ext.get( Ext.query('#disconnect') ).on( 'click', function(){
        Ext.get('body').mask( BR.lang.loadingLogout );
        Ext.Ajax.request({
            url: 'services/logout.aspx',
            success: function(response){
                window.location.reload();
            },
            failure: function(response){
                window.location.reload();
            }
        });
    });
};

