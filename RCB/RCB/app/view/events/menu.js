Ext.define('BR.view.events.menu', {
    extend: 'Ext.menu.Menu',
    alias: 'widget.menuEvents',
    initComponent: function() {
        Ext.apply(this, {
            items: [{
                text: BR.lang.btn.edit,
                iconCls: 'icon-edit',
                action: 'edit'
            },{
                text: BR.lang.btn.del,
                iconCls: 'icon-delete',
                action: 'delete'
            }]
        });
        this.callParent(arguments);
    }
});
