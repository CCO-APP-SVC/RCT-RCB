Ext.define('BR.view.myEventsTree' ,{
    extend: 'Ext.tree.Panel',
    alias : 'widget.myEventsTree',
    requires: ['BR.store.Events'],
    id: 'events-tree',
    title: BR.lang.event.panelTitle,
    region:'west',
    useArrows: false,
    hideHeaders: true,
    rootVisible: false,
    displayField: 'name-' + BR.lang.lang,
    width: 250,
    border: true,
    bodyStyle: {
       padding: '10px 0'
    },
    dockedItems: [{
        xtype: 'toolbar',
        dock: 'top',
        items: [{
            xtype: 'button',
            action: 'add',
            text: BR.lang.btn.add,
            iconCls: 'icon-add'
        },'-',{
            xtype: 'button',
            text: BR.lang.btn.edit,
            action: 'edit',
            disabled: true,
            iconCls: 'icon-edit'  
        },{
            xtype: 'button',
            text: BR.lang.btn.del,
            action: 'delete',
            disabled: true,
            iconCls: 'icon-delete'  
        }]
    }],

    // Not supposed to use this here (Might only be set in controller)...
    initComponent: function() {
        var me = this;
        Ext.apply(me, {
            store: Ext.create('BR.store.Events')
        });
        me.callParent(arguments);
    }

});



