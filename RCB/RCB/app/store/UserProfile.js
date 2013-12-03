Ext.define('BR.store.UserProfile', {
    extend: 'Ext.data.Store',
    model: 'BR.model.UserProfile',
    storeId: 'UserProfileStore',
    proxy: {
        type: 'ajax',
        url:'services/getUserProfile.aspx',
        reader: {
            type: 'json',
            root: 'children'
        }
    }
});
