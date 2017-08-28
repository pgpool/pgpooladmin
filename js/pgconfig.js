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
});
