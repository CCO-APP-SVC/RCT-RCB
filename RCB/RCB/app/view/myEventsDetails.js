Ext.define('BR.view.myEventsDetails' ,{
    extend: 'Ext.grid.Panel',
    alias : 'widget.myEventsDetails',
    border: 0,
    autoScroll: true,
    region: 'center',
    layout: 'auto',
    autoScroll: true,
    columnLines: true,
    columns: [{
        text: 'Id',
        width: 25,
        sortable: true,
        hideable: false,
        dataIndex: 'id'
    },{
        text: BR.lang.comp.frTitle,
        width: 150,
        sortable: false,
        hideable: false,
        dataIndex: 'title-fr'
    },{
        text: BR.lang.comp.enTitle,
        width: 200,
        sortable: false,
        hideable: false,
        dataIndex: 'title-en'
    },{
        text: BR.lang.comp.final,
        dataIndex: 'showFinal',
        sortable: false,
        hideable: false
    },{
        text: BR.lang.comp.lastImport,
        dataIndex: 'lastDate',
        sortable: false,
        hideable: false,
        flex: 1
    }],
   initComponent: function() {
        Ext.apply(this, {
             store: Ext.create('BR.store.Comps')
        });
        this.callParent(arguments);
    },
    tbar:[{
        text: BR.lang.btn.add,
        tooltip: BR.lang.tip.addComp,
        action: 'add',
        iconCls: 'icon-add'
    }, '-',{
        text:  BR.lang.btn.edit,
        tooltip: BR.lang.tip.editComp,
        iconCls: 'icon-edit',
        action: 'edit',
        disabled: true
    },{
        text:  BR.lang.btn.del,
        tooltip: BR.lang.btn.deleteComp,
        iconCls: 'icon-delete',
        action: 'delete',
        disabled: true
    },{
        text: BR.lang.btn.imp,
        tooltip: BR.lang.btn.importComp,
        iconCls: 'icon-import',
        action: 'import',
        disabled: true
    },{
        text: BR.lang.btn.impFinal,
        tooltip: BR.lang.btn.importFinal,
        iconCls: 'icon-import',
        action: 'importFinal',
        disabled: true
    },{
        text: BR.lang.btn.show,
        tooltip: BR.lang.btn.showComp,
        iconCls: 'icon-view',
        action: 'view',
        disabled: true
    }],
    viewConfig: {
        stripRows: true
    }
});


