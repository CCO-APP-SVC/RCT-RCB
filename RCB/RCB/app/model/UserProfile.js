Ext.define('BR.model.UserProfile', {
    extend: 'Ext.data.Model',
    idProperty: 'uid',
    fields: [
        {name: 'uid',          type: 'int'},
        {name: 'username',     type: 'string'},
        {name: 'admin',        type: 'bool'}
    ]
});

