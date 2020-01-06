var invent = {
    init : ()  => {
        jQuery(document).ready(() => {
        jQuery('.sidenav').sidenav();
        jQuery('.collapsible').collapsible();
        jQuery('select').formSelect();
        jQuery("time.timeago").timeago();
        });
    },
    product : {
        submit : ()  => {
            if (((jQuery("#product_name").val()).replace(/\s/g, "")) == ""){
                M.toast({html: 'Enter product name.', classes: 'rounded error'});
                jQuery("#product_name").val("");
                jQuery("#product_name").focus();
                return false;
            }
            return true;
        }
    },
    location : {
        submit : ()  => {
            if (((jQuery("#location_name").val()).replace(/\s/g, "")) == ""){
                M.toast({html: 'Enter location name.', classes: 'rounded error'});
                jQuery("#location_name").val("");
                jQuery("#location_name").focus();
                return false;
            }
            return true;
        }
    },
    movement : {
        submit : ()  => {
            if (((jQuery("#from").val()).replace(/\s/g, "")) == "" && ((jQuery("#from").val()).replace(/\s/g, "")) == ""){
                M.toast({html: 'From and To can not be empty at same time.', classes: 'rounded error'});
                jQuery("#from").focus();
                return false;
            }
            else if(jQuery("#from").val() == jQuery("#to").val()){
                M.toast({html: 'From and To can not be same.', classes: 'rounded error'});
                jQuery("#from").val("");
                jQuery("#from").focus();
                return false;
            }
            else if(((jQuery("#pname").val()).replace(/\s/g, "")) == ""){
                M.toast({html: 'Select a product.', classes: 'rounded error'});
                jQuery("#pname").focus();
                return false;
            }
            else if(((jQuery("#quantity").val()).replace(/\s/g, "")) == ""){
                M.toast({html: 'Quantity can not be empty.', classes: 'rounded error'});
                jQuery("#quantity").val("");
                jQuery("#quantity").focus();
                return false;
            }
            else if(isNaN(jQuery("#quantity").val())){
                M.toast({html: 'Quantity must be numeric.', classes: 'rounded error'});
                jQuery("#quantity").val("");
                jQuery("#quantity").focus();
                return false;
            }
            return true;
        }
    },
    register : {
        submit : () => {
            if (jQuery("#password").val() != jQuery("#cnfpassword").val()){
                M.toast({html: 'Password and Confirm password are not same.', classes: 'rounded error'});
                return false;
            }
            return true;
        }
    }

}