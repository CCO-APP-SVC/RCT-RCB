Ext.define('BR.store.Comps', {
    extend: 'Ext.data.Store',
    requires: ['Ext.data.Store'],
    model: 'BR.model.Comp',
    proxy: {
        type: 'ajax',
        url:'services/getCompetitions.aspx',
        reader: {
            type: 'xml',
            record: 'Comp',
            idProperty: 'id'
        }
    },
    sorters: [{
        property: 'id',
        direction: 'DESC'
    }]
});
