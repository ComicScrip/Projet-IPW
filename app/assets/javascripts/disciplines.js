$(document).on('disciplines#edit_students:loaded', function(){
    var discipline_id = $('#discipline_id').val();
    var selectedStudentsIds = [];

    $.ajax({
        type: "GET",
        url: "/disciplines/" + discipline_id + "/get_students_for_discipline",
        dataType: "json",
        success: function(students){
            initStudentSelection(students);
        }
    });

    $('#update_discipline_students').on('click', function (e) {
        e.preventDefault();
        selectedStudentsIds = $('#discipline_students').val();
        $.ajax({
            type: "POST",
            url: "/disciplines/" + discipline_id + "/update_students",
            data: {selectedStudentsIds: selectedStudentsIds},
            dataType: "json",
            success: function(){
                var successFlash =
                    '<div class="flash alert alert-dismissable alert-success">' +
                    '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>' +
                    'La liste des étudiants a bien été mise à jour.</div>';
                successFlash = $(successFlash);
                $('#flash_messages').empty();
                successFlash.appendTo($('#flash_messages')).hide().slideDown(500);
            }
        });
    });
});

function initStudentSelection(students) {
    var select = $('#discipline_students').select2({
        theme: 'bootstrap',
        data: students,
        language: 'fr',
        placeholder: 'sélectionnez des étudiants...'
    });
}

