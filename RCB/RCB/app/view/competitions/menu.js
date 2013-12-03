Ext.define('BR.view.competitions.menu', {
    extend: 'Ext.menu.Menu',
    alias: 'widget.menuComps',
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
            },{
                text: BR.lang.btn.importShort,
                iconCls: 'icon-import',
                action: 'import'
            },{
                text: BR.lang.btn.showShort,
                iconCls: 'icon-view',
                action: 'view'
            }]
        });
        this.callParent(arguments);
    }
});
