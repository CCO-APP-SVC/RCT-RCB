Ext.define('BR.model.Comp', {
    extend: 'Ext.data.Model',
    fields: [
       // {name: 'id', mapping: 'Comp > id', type: 'int', sortType: 'asInt' },
        {name: 'eid', mapping: 'Comp > eid', type: 'int'},
       // 'id',
{name: 'id', sortType: 'asInt' },
        'eid',
        'title-fr',
        'title-en',
        'lastDate',
        'type',
        'showFinal'
    ]
});
