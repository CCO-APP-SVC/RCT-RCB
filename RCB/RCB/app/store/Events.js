Ext.define('BR.store.Events', {
    extend: 'Ext.data.TreeStore',
    requires: ['Ext.data.TreeStore'],
    fields: [
        {name: 'id',       type: 'integer'},
        {name: 'name-fr',  type: 'string'},
        {name: 'name-en',  type: 'string'},
        {name: 'iconCls',  type: 'string', defaultValue: 'icon-events', convert: null},
        {name: 'leaf',     type: 'boolean', defaultValue: true, convert: null}
    ],

    setText: function() {
        console.log( this );
    },

    proxy: {
        type: 'ajax',
        url:'services/getEvents.aspx',
        reader: {
            type: 'xml',
            root: 'NewDataSet',
            record: 'Events'
        }
    },
    sorters: [{
        property: 'id',
        direction: 'DESC'
    }],
    root: {
        id: 'id',
        expanded: true
    }

});



