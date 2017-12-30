
<div class="c5"></div>
<div class="breadLine">
    <ul class="breadcrumb">
        <li><a href="?"><i class="icon-home"></i></a></li>
        Company on the map
    </ul>
</div>
<div class="c20"></div>
  
<div class="wraper-content">
<!-- START BLOCK : msg -->
<div>{msg}</div>
<!-- END BLOCK : msg --> 
<!-- START BLOCK : AddNew -->
<form action="{action}" method="post" id="inputform" onSubmit="return check_null();" enctype="multipart/form-data">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table-bordered tabletdnone">
      <tr>
        <th colspan="2"><i class="icon-pencil icon-white"></i>&nbsp;Thông tin liên hệ</th>
      </tr>
      <tr>
        <td width="150"><strong>Tiêu đề</strong></td>
        <td><input type="text" name="name" class="txtform100 notNull" value="{name}" data-alert="Bạn cần nhập vào tiêu đề {item}"/></td>
      </tr>
      <tr>
        <td valign="top"><strong>Chi tiết</strong></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2">{content}</td>
      </tr>
      <tr>
        <td valign="top"><strong>Google Map</strong></td>
        <td>
        
        	<div class="input-group" style="float:left">
			  <span class="input-group-addon" style="width:60px; display:block; float:left; line-height:25px;">Tiêu đề</span>
			  <input name="maptitle" id="hfTitle" type="text" class="form-control input-lg" placeholder="Tiêu đề" value="{maptitle}">
			</div>
  <div class="input-group" style="float:left; margin-left:10px;">
			  <span class="input-group-addon"  style="width:60px; display:block;float:left;line-height:25px;">Địa chỉ</span>
			  <input name="mapaddress" id="txtAddress" type="text" class="form-control input-lg" placeholder="Tìm địa chỉ" value="{mapaddress}">
              <div class="btn" onclick="getAddress(); return false">Tìm</div>
			</div>
            <div class="c5"></div>
            <div class="input-group" style="float:left">
			  <span class="input-group-addon"  style="width:60px; display:block;float:left;line-height:25px;">Latitude</span>
			  <input type="text" class="form-control input-lg" placeholder="Tiêu đề" name="latitude"  id="txtLatitude" value="{latitude}">
			</div>
            <div class="input-group" style="float:left; margin-left:10px;">
			  <span class="input-group-addon"  style="width:60px; display:block;float:left;line-height:25px;" >Longitude</span>
			  <input type="text" class="form-control input-lg" placeholder="Longitude" name="longitude"  id="txtLongitude" value="{longitude}">
			</div>
            <div class="c10" style="clear:both"></div>
            <div style="border:solid 1px #CCC; width:600px; height:300px;" id="showMap">
            	
            </div>
        </td>
      </tr>
      <tr>
        <td><strong>Kích hoạt</strong></td>
        <td><input type="checkbox" name="active" id="active" value="1" {active} /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td><a class="btn btn-primary" onClick="$('#inputform').submit(); return false"><i class="icon-ok-circle icon-white"></i>&nbsp;Cập nhật</a></td>
      </tr>
    </table>
</form>
<div class="divider1"><span></span></div>
<script type="text/javascript">
$(function() {
    $('#ngay_dang').datepicker({
		  duration: '',
		  showTime: true,
		  constrainInput: false,
		  dateFormat: 'dd/mm/yy',
		  changeYear: true,
		  changeMonth: true,
		  showOtherMonths: true,
		  time24h: true,
		  currentText: 'Today'							
  });
});
$(function(){
	$('#divremovea').html(CKEDITOR.instances.content.getData()) ;
	$('#divremovea img').each(function(){
		$('#load').append('<div class="cell_multi_upload"><div class="defaultimage"><input name="defaultimage" onchange="insert_image_default(\'' + $(this).attr('src') + '\')" type="radio" value="' + $(this).attr('src') + '"  /></div><img src="{dir_path}/manager/image.php?w=130&h=90&src=' + $(this).attr('src') + '" /><div class="tool"><a href="#" onclick="insertimage(\'' + $(this).attr('src') + '\');return false">Chèn</a> | <a href="#" class="a_deleteimage" onclick="deleteimage(\'' + $(this).attr('src') + '\',\'' + $(this).attr('src') + '\',$(this));return false">Xóa</a></div></div>');
	});
	
});

function get_image_url(){
	var n = 0;
	$('#load .cell_multi_upload').each(function(){
		n++;
	});
	$('#divremovea').html(CKEDITOR.instances.content.getData()) ;
	$('#divremovea img').each(function(){
		 n++;
		 var imagei = $(this);
		 imagei.attr('data-image',n);
		 $('#load').append('<div class="cell_multi_upload" id="uploaded_file_' + n + '"><div class="progress progress-striped active"><div class="bar" style="width: 100%;"></div></div></div>');
		 
		 $.ajax({
		   type: "GET",
		   url: "index4.php?page=action_ajax&code=uploadimageurl",
		   data: "url="+$(this).attr('src'),
		   success: function(response){
			  response = response.replace(/^\s+|\s+$/g,'');
			  imagei.attr('src',response);
			  $('#uploaded_file_' + imagei.attr('data-image')).html('<div class="defaultimage"><input name="defaultimage" onchange="insert_image_default(\'' + response + '\')" type="radio" value="' + response + '"  /></div><img src="{dir_path}/manager/image.php?w=130&h=90&src=' + response + '" /><div class="tool"><a href="#" onclick="insertimage(\'' + response + '\');return false">Chèn</a> | <a href="#" class="a_deleteimage" onclick="deleteimage(\'' + response + '\',\'' + response + '\',$(this));return false">Xóa</a></div>');
		   }
		 });
		 
		
	});	
}
$('#putToEditor').click(function(){
	CKEDITOR.instances.content.setData ($('#divremovea').html());
	return false;
});
function insert_image_default(url){
	$('#imageurl').attr('value',url);
	$('#pic_avatar').html('<img src="image.php?w=150&src=' + url + '" class="img-polaroid marginright5" align="left" id="avatar" />');
}
</script>

<!-- END BLOCK : AddNew -->

<!-- START BLOCK : showList -->
<form action="{action}" method="post" id="list_form">
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table table-bordered table-striped table-hover">
							 
  <tr>
    <th colspan="5">
        <div style="float:left"><i class="icon-list-alt icon-white"></i>&nbsp;Danh sách {item}</div>
        <a href="?page={par_page}&code=showAddNew&pid={pid}" style="float:right"><div class="btn  btn-mini"><i class="icon-plus-sign"></i>&nbsp;Thêm mới {item}</div></a>
    </th>
  </tr>
  
  <tr class="title">
    <td width="16"><input type="checkbox" name="checkbox" id="checkbox" class="cat_check" data-check="cat_check" onClick="check_all(this)" /></td>
    <td>Tiêu đề</td>
    <td width="60" align="center" class="center">Kích hoạt</td>
    <td width="30" align="center">Sửa</td>
    <td width="30" align="center">Xóa</td>
  </tr>
  <!-- START BLOCK : list -->
  <tr>
    <td width="16"><input type="checkbox" name="delmulti[{id}]" id="checkbox" class="cat_check" value="{id}" /></td>
    <td>
      <div class="list_item_name"><a href="{link_edit}">{name}</a></div>
    </td>
    <td class="center"><input type="checkbox" name="active" value="1" data-active="{id}" {active} class="changeactive"/></td>
    <td><a href="{link_edit}" class="btn padingleftright4"><i class="icon-wrench"></i></a></td>
    <td><a href="{link_delete}" class="trash_item btn padingleftright4"><i class="icon-trash"></i></a></td>
  </tr>
  <!-- END BLOCK : list -->

  <tr class="title">
    <td width="16"><input type="checkbox" name="checkbox" id="checkbox" class="cat_check" onClick="check_all($(this))"/></td>
    <td><a href="?page={par_page}&code=deletemulti" id="delmultiitem">Xóa tất cả mục đã chọn</a></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr class="search_box nonehover">
    <td colspan="5">
           {pages}
    </td>
  </tr>
</table>
</form>
<!-- END BLOCK : showList -->
<div class="divider1"><span></span></div>
<div id="divremovea" style="display:none"></div>
</div>

<script>
$(function(){
	/// delete image
	$('#trash_image').click(function(){
		$('#trash_image').fadeTo('fast',0.3)
		show_mes('Đang thực hiện !');
		$("#divremovea").load($('#trash_image').attr('href'), function(response, status, xhr) {
		  if (status == "error") {
			var msg = "Sorry but there was an error: ";
			alert(msg + xhr.status + " " + xhr.statusText);
		  }
		  if(status == 'success'){
			  $('#avatar').remove();
			  $('#trash_image').remove();
			  show_mes('Đã xóa ảnh xong !');
		  }
		});
		return false;
	});
	
	// delete record
	$('.trash_item').click(function(){
		if(confirm('Bạn có thật sự muốn xóa không ?')){
			obj=$(this);
			show_mes('Đang thực hiện !');
			obj.parent().parent().fadeTo('fast', 0.3);
			$("#divremovea").load('index4.php' + obj.attr('href'), function(response, status, xhr) {
			  if (status == "error") {
				var msg = "Sorry but there was an error: ";
				alert(msg + xhr.status + " " + xhr.statusText);
			  }
			  if(status == 'success'){
				  obj.parent().parent().remove();
				   show_mes('Đã xóa xong');
			  }
			});
			return false;
		}else{
			return false;	
			show_mes('Đã hủy lệnh !');
		}
		
	});
	
	$('#delmultiitem').click(function(){
		if(confirm('Bạn có thật sự muốn xóa những mục đã chọn không ?')){
			$('#list_form').attr('action',$(this).attr('href'));
			$('#list_form').submit();
		}else{
			return false;	
		}
		return false;
	})
	// go to category
	$('#parentid').change(function(){
		window.location='?page={par_page}&pid=' + $(this).val();
	});
	
	// change active
	$('.changeactive').change(function(){
		show_mes('Đang thực hiện !');
		var obj = $(this);
		var active = 0;
		var mes ='Đã bỏ kích hoạt !';
		if(obj.is(":checked")){
			active = 1		
			mes = "Đã kích hoạt !";
		}
		obj.fadeTo('fast',0.3)
		$("#divremovea").load('index4.php?page=action_ajax&code=change_active&table={table}&id_item={id_item}&id=' + obj.attr('data-active') + '&active=' + active, function(response, status, xhr) {
		  if (status == "error") {
			var msg = "Sorry but there was an error: ";
			alert(msg + xhr.status + " " + xhr.statusText);
		  }
		  if(status == 'success'){
			  show_mes(mes);
			  obj.fadeTo('fast',1);
		  }
		});
	});
});


// block ui

// tool editor
function remove_A(){ // remove tag a
	$('#divremovea').html(CKEDITOR.instances.content.getData()) ;
	$("#divremovea a").each(function(){
		 $(this).replaceWith('<span>' + $(this).html() + '</span>');
	});
	CKEDITOR.instances.content.setData ($('#divremovea').html());
	
}
function table_center(){ // table to center
	$('#divremovea').html(CKEDITOR.instances.content.getData()) ;
	$("#divremovea table").each(function(){
		 //$(this).replaceWith('<span>' + $(this).html() + '</span>');
		 $(this).attr('align','center');
	});
	CKEDITOR.instances.content.setData ($('#divremovea').html());
}
function td_text_italic(){ // text italic in td 
	$('#divremovea').html(CKEDITOR.instances.content.getData()) ;
	$("#divremovea table td").each(function(){
		 $(this).css('font-style','italic');
	});
	CKEDITOR.instances.content.setData ($('#divremovea').html());
}
function td_text_center(){ // text center in td
	$('#divremovea').html(CKEDITOR.instances.content.getData()) ;
	$("#divremovea table td").each(function(){
		 $(this).css('text-align','center');
		
	});
	CKEDITOR.instances.content.setData ($('#divremovea').html());
}
function image_center(){ // image to center
	$('#divremovea').html(CKEDITOR.instances.content.getData()) ;
	$("#divremovea img").each(function(){
		if($(this).attr('alt')){
			var curAlt = $(this).attr('alt');		
		}
		if($(this).attr('title')){
			
			var curTitle = $(this).attr('title');		
		}
		
		$(this).replaceWith('<div align="center"><img src="'+ $(this).attr('src') +'"  /></div>');
		//$(this).css('margin','0 auto');
	});
	CKEDITOR.instances.content.setData ($('#divremovea').html());
}
function remove_P(){ // remove tag p
	$('#divremovea').html(CKEDITOR.instances.content.getData()) ;
	$("#divremovea p").each(function(){
		 $(this).replaceWith('<div>' + $(this).html() + '</div>');
	});
	CKEDITOR.instances.content.setData ($('#divremovea').html());
}
</script>

<script>

function deleteimage(url,urlthumb,obj){
	obj.parent().parent().fadeTo('fast',0.3);
	$("#divremovea").load('index4.php?page=action_ajax&code=deleteimageurl&image=' + url + '&urlthumb=' + urlthumb, function(response, status, xhr) {
	  if (status == "error") {
		var msg = "Sorry but there was an error: ";
		alert(msg + xhr.status + " " + xhr.statusText);
	  }
	  if(status == 'success'){
		  obj.parent().parent().remove();
	  }
	});
}
function insertimage(url){
	CKEDITOR.instances.content.insertHtml( '<img src=' + url + ' />' );
}

</script>

<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false" type="text/javascript"></script>
    <script type="text/javascript">
        var infowindow = new google.maps.InfoWindow({
            maxWidth: 500
        });

        var geocoder;
        var map;
        var zoomIn = 13;
        var markersArray = [];

        // initialize
        function initialize() {
            var title = $('#hfTitle').val();
            var lat = $('#txtLatitude').val();
            var lng = $('#txtLongitude').val();

            lat = lat.replace(",", ".");
            lng = lng.replace(",", ".");
            if (!lat) lat = 0;
            if (!lng) lng = 0;

            var latLng;
            if (lat > 0 && lng > 0) {
                latLng = new google.maps.LatLng(lat, lng);
            }
            else {
                latLng = new google.maps.LatLng(21.042324102802453, 105.77579302215577);
            }

            // geocoder init
            geocoder = new google.maps.Geocoder();

            // map options
            var myOptions = {
                zoom: zoomIn,
                center: latLng,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };

            // init map
            map = new google.maps.Map(document.getElementById('showMap'), myOptions);

            // create marker
            $('#txtLatitude').attr('value', latLng.lat().toString());
            $('#txtLongitude').attr('value', latLng.lng().toString());
            createMarker(latLng, title);
        }

        function getAddress() {
            var address = $('#txtAddress').val();
            geocoder.geocode({ 'address': address }, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    map.setCenter(results[0].geometry.location);
                    createMarker(results[0].geometry.location, "");

                    $('#txtLatitude').attr('value', results[0].geometry.location.lat());
                    $('#txtLongitude').attr('value', results[0].geometry.location.lng());
                } else {
                    alert("Geocode was not successful for the following reason: " + status);
                }
            });
        }

        // create marker
        function createMarker(latLng, html) {
            var marker = new google.maps.Marker({
                position: latLng,
                map: map,
                draggable: true
            });

            infowindow.setContent(html);
            infowindow.open(map, marker);

            google.maps.event.addListener(marker, 'dragstart', function () {

            });

            google.maps.event.addListener(marker, 'drag', function () {
                updateMarkerPosition(marker.getPosition());
            });

            google.maps.event.addListener(marker, 'dragend', function () {

            });

            if (markersArray) {
                for (i in markersArray) {
                    markersArray[i].setMap(null);
                }
            }

            markersArray.push(marker);
            return marker;
        }

        function updateMarkerPosition(latLng) {
            $('#txtLatitude').val(latLng.lat().toString());
            $('#txtLongitude').val(latLng.lng().toString());
        }

        // Init Google Map
        google.maps.event.addDomListener(window, 'load', initialize);
    </script>