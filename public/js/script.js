$(document).ready(function(){


	$('.button1').click(function(){
	    $('#wrapper').css("background", 'grey');
	    $('#wrapper').css('opacity', 0.8);
	    $('#wrapper').css('background', 'rgba(0,0,0,0.5)');
	    $('#signup').show();
	    
	   
    });
  
        $('.button2').on('click',function(){
           $('#button').css('background', 'rgba(0,0,0,0.0)');
           $("#signup").hide();

        	
    }); 
        

});