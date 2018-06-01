$(function () {

    $('.story-item-popup').magnificPopup({
        items: {
            src: '#story-detail-dialog',
            type: 'inline',
        },
        fixedContentPos: false,
        fixedBgPos: true,
        overflowY: 'auto',
        closeBtnInside: true,
        preloader: false,
        midClick: true,
        removalDelay: 300,
        mainClass: 'my-mfp-zoom-in'
    });

    $('.story-item-popup').click(function(e){
        $('#story-detail-content').html($('.loading_section').html());
        $.ajax({
            url: $(this).data('story-path'),
            dataType: 'script'
        })
    })

    $('.story-item-popup a').click(function(e){
        e.stopPropagation();
    })
})
