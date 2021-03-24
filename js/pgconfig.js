$(window).load(function()
{
    $('input[type="radio"], select').each(function()
    {
        toggleTbody($(this));
    });
    $('input[type="radio"], select').change(function()
    {
        toggleTbody($(this));
    });

    /* ========================================================================= */
    /* If no health check config of this node,                                   */
    /* don't show the per node health check form.                                */
    /* ========================================================================= */

    $('[id^=tr_hc_node_num_]').each(function()
    {
        var tt = null;
        tt = $(this).nextAll('tr').find('input[value!=""]').val();
        if ( tt === undefined) {
            $(this).nextAll('tr').css('display', 'none');
        }
    });

    /* ========================================================================= */
    /* In per node health check form,                                            */
    /* input "name" is like "health_check_period0", "health_check_period1"       */
    /* ========================================================================= */
    $('[id^=tb_per_node_healthcheck_]').find('input[name^=health_check], input[name=connect_timeout]').each(function()
    {
        var node_num = $(this).parents('tbody').attr('id').split('_')[4];
        var name = $(this).attr('name');
        $(this).attr('name', name + node_num)
    });

    /* ========================================================================= */
    /* Click "add" button                                                        */
    /* ========================================================================= */

    /* Click "add" button to add backends form and add per node health_check row */
    $('#add_backends_node').click(function()
    {
        var next_node_num = $('[id^=tb_backends_node_]').length;
        var pgpool_ver = $('#pgpool_ver').val();

        addBackendForm(next_node_num);

        /* Only show per node health check form when pgpool version >= 3.7.*/
        if (pgpool_ver >= 3.7) {
            addPerNodeHealthCheck(next_node_num);
        }
    });

    /* Click "add" button to add per node health_check. */
    $('[id^=add_per_node_health_check_]').click(function()
    {
        addPerNodeHealthCheckForm($(this));
    });

    /* Click "add" button to add watchdog form */
    $('#add_watchdog_node').click(function()
    {
        var next_node_num = $('[id^=tr_wd_node_num_]').length;
        addWatchdogNodeForm(next_node_num);
    });

    $('#add_watchdog_heartbeat_node').click(function()
    {
        var next_node_num = $('[id^=tr_wd_hb_num_]').length;
        addWdHbForm(next_node_num);
    });

    /* ========================================================================= */
    /* Click "delete" button                                                     */
    /* ========================================================================= */

    /* Delete backends form */
    $('[id^=delete_backends_node_]').on({'click': deleteBackendForm});

    /* Delete per node health_check form. */
    $('[id^=delete_per_node_health_check_]').on({'click': deletePerNodeHealthCheckForm});

    /* Delete watchdog form */
    $('[id^=delete_watchdog_node_]').on({'click': deleteWatchdogForm});

    /* Delete watchdog heartbeat destination form */
    $('[id^=delete_watchdog_heartbeat_node_]').on({'click': deleteWdHbForm});

});

function sendForm(action, num)
{
    $('#pgconfig_action').val(action);
    if (num != null) {
        $('#pgconfig_num').val(num);
    }
    $('#form_pgconfig').submit();
}

function toggleTbody(item)
{
    var param_name = $(item).attr('name');
    var tagname = item.prop('tagName');
    var val = null;

    if (tagname == 'INPUT' && $(item).attr('type') == 'radio') {
        val = $(item).filter(':checked').val();
        if (val === undefined) {
            return;
        }

    } else if (tagname == 'SELECT') {
        val = $(item).children('option').filter(':selected').val();

    }

    var tbody_id_to_enable = param_name + '_' + val;

    $('tbody[id^="tb_"][id*="' + param_name + '_"]').each(function()
    {
        var tbody_id = $(this).attr('id');
        var enabled = ($('[name="' + param_name + '"]').prop('disabled') == false &&
                       tbody_id.indexOf(tbody_id_to_enable) != -1);

        $('#' + tbody_id + ' input').prop('disabled', ! enabled);
        $('#' + tbody_id + ' select').prop('disabled', ! enabled);

        $('#' + tbody_id + ' select').each(function()
        {
            toggleTbody($(this));
        });
    });
}

/*
 * Add backends form by using "add" button
 */
function addBackendForm(next_node_num)
{

    var html = '<tbody id="tb_backends_node_' + next_node_num + '">' +
               '<tr id="tr_ba_node_num_' + next_node_num +
               '" name="tr_ba_node_num"><th colspan="2">' +
               '<span class="param_group">Backend node ' + next_node_num + '</span>' +
               '</th></tr>';

    $('tr[name="tr_ba_node_num"]').last().nextAll('tr').each(function()
    {
        html += '<tr>' + $(this).html() + '</tr>';
    });
    html += '</tbody>';

    $('#t_backends').append(html);
    $('#tr_ba_node_num_' + next_node_num).nextAll('tr').find('input').val('');

}

/*
 * clicking backends "add" button to add per node health_check row.
 */
function addPerNodeHealthCheck(next_node_num)
{
    var html = '<tbody id="tb_per_node_healthcheck_' + next_node_num + '">' +
               '<tr id="tr_hc_node_num_' + next_node_num +
               '" name="tr_hc_node_num"><th colspan="2">' +
               '<span class="param_group">Backend node ' + next_node_num + '</span>' +
               '<input id="add_per_node_health_check_' + next_node_num +
               '" type="button" name="add" value="Add" onclick="addPerNodeHealthCheckForm($(this))" />' +
               '</th></tr>';

    $('#tb_global_healthcheck').find('tr').each(function()
    {
        html += '<tr style="display: none">' + $(this).html() + '</tr>';
    });

    html += '</tbody>';

    $('#t_healthcheck').append(html);
    $('#tr_hc_node_num_' + next_node_num).nextAll('tr').find('input').val('');

    $('#tb_per_node_healthcheck_' + next_node_num).find('input[name^=health_check], input[name=connect_timeout]').each(function()
    {
        var name = $(this).attr('name');
        $(this).attr('name', name + next_node_num)
    });
}

/*
 * Add per node health check form by using "add" button of health check table.
 */
function addPerNodeHealthCheckForm(obj)
{
    var node_num = obj.parents('tbody').attr('id').split('_')[4];

    obj.parents('tbody').find('tr').show();
    $('#tr_hc_node_num_' + node_num).nextAll('tr').find('input').val('');
}

/*
 * Add watchdog form by using "add" button
 */
function addWatchdogNodeForm(next_node_num)
{
    var html = '<tbody id="tb_watchdog_use_watchdog_on_node_' + next_node_num + '">' +
               '<tr id="tr_wd_node_num_' + next_node_num +
               '" name="tr_wd_node_num"><th colspan="2">' +
               '<span class="param_group">Watchdog node ' + next_node_num + '</span>' +
               '</th></tr>';
    $('tr[name="tr_wd_node_num"]').last().nextAll('tr').each(function()
    {
        html += '<tr>' + $(this).html() + '</tr>';
    });
    html += '</tbody>';

    $('#tb_watchdog_use_watchdog_on_node_' + (next_node_num - 1) ).after(html);
    $('#tr_wd_node_num_' + next_node_num).nextAll('tr').find('input').val('');
}

/*
 * Add watchdog form by using "add" button
 */
function addWdHbForm(next_node_num)
{
    var html = '<tbody id="tb_watchdog_use_watchdog_on_wd_heartbeat_' + next_node_num + '">' +
               '<tr id="tr_wd_hb_num_' + next_node_num +
               '" name="tr_wd_hb_num"><th colspan="2">' +
               '<span class="param_group">Heartbeat destination ' + next_node_num + '</span>' +
               '</th></tr>';

    $('tr[name="tr_wd_hb_num"]').last().nextAll('tr').each(function()
    {
        html += '<tr>' + $(this).html() + '</tr>';
    });

    html += '</tbody>';

    $('#tb_watchdog_use_watchdog_on_wd_heartbeat_' + (next_node_num - 1) ).after(html);
    $('#tr_wd_hb_num_' + next_node_num).nextAll('tr').find('input').val('');
}

/*
 * Delete backend node form
 */
var deleteBackendForm = function()
{
    var deleted_node_num = $(this).attr('id').split('_')[3];
    $('#tb_backends_node_' + deleted_node_num).remove();
}

/*
 * Delete per node health check form
 */
var deletePerNodeHealthCheckForm = function()
{
    var node_num = $(this).parents('tbody').attr('id').split('_')[4];

    $('#tr_hc_node_num_' + node_num).nextAll('tr').find('input').val('');
    $(this).parents('tr').nextAll('tr').css('display', 'none');
}

/*
 * Delete watchdog form
 */
var deleteWatchdogForm = function()
{
    var node_num = $(this).attr('id').split('_')[3];
    $('#tb_watchdog_use_watchdog_on_node_' + node_num).remove();
}

/*
 * Delete watchdog heartbeat form
 */
var deleteWdHbForm = function()
{
    var node_num = $(this).attr('id').split('_')[4];
    $('#tb_watchdog_use_watchdog_on_wd_heartbeat_' + node_num).remove();
}
