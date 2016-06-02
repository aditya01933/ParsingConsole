var timeOutId = 0;
	function tick() {
			var time_now = $("#last_time").text();
			var job_id =  $("#job_id").text();
            var finish_task = $("#done").text();
          if (finish_task == "done"){
            clearTimeout(timeOutId);
        } else {   
      var ajaxOpts = {
            type: "get",
            url: "/job_statuses",            
            data: {time : time_now, job_id : job_id},
            cache: false
                                   
        };}
    $.ajax(ajaxOpts);
    timeOutId = setTimeout('tick()', 100);
   

    

}

$(document).ready(function() {
    tick();
});