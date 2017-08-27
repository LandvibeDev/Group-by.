


$('.email-view').on('click',function(e) {

    var emailOpened = $('[data-email="opened"]');

    var id = e.target.id.split("/@@/");
    var email = null;

    var email_from = id[1];
    var email_date = id[5];
    var email_subject =id[4];
    var email_content = id[3];
    var email_to = id[2];

    console.log(email_content)

    var thumbnailWrapper = $(this).find('.thumbnail-wrapper');

        emailOpened.find('.sender .name').text(email_from);
        emailOpened.find('.sender .datetime').text(email_date);
        emailOpened.find('.subject').text(email_subject);
        emailOpened.find('.email-content-body').html(email_content);
        emailOpened.find('.inline #to').text(email_to);

        // Initialize email action menu
        $('.menuclipper').menuclipper({
            bufferWidth: 20
        });

        $('.no-result').hide();
        $('.actions-dropdown').toggle();
        $('.actions, .email-content-wrapper').show();

        if ($.Pages.isVisibleSm() || $.Pages.isVisibleXs()) {
            $('.split-list').toggleClass('slideLeft');
        }

        $('.item').removeClass('active');
        $(this).addClass('active');

    });