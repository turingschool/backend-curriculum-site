document.getElementById('child_many_to_many_html').style.display = 'none'
document.getElementById('parent_many_to_many_html').style.display = 'none'

function updateUserStories(){
    var parent_model_name = format_and_capitalize('parent_model_name_input');
    var child_model_name = format_and_capitalize('child_model_name_input');
    var new_model_name = format_and_capitalize('new_model_name_input');
    var parent_name_elements = document.getElementsByClassName('parent_model_name');
    var child_name_elements = document.getElementsByClassName('child_model_name');
    var new_model_name_elements = document.getElementsByClassName('new_model_name');
    var table_type = document.getElementById('related_table_type_input').value
    for (var i=0; i< new_model_name_elements.length; i++){
        element = new_model_name_elements[i]
        model_name_with_proper_formatting = proper_formatting(new_model_name, element);
        element.innerHTML = model_name_with_proper_formatting
    }
    for (var i = 0; i < parent_name_elements.length; i++) {
            element = parent_name_elements[i]
            model_name_with_proper_formatting = proper_formatting(parent_model_name, element);
            element.innerHTML = model_name_with_proper_formatting;
        }
        for (var i=0; i< child_name_elements.length; i++){
            element = child_name_elements[i]
            model_name_with_proper_formatting = proper_formatting(child_model_name, element);
            element.innerHTML = model_name_with_proper_formatting
        }
        if (table_type == 'parent') {
            document.getElementById('parent_many_to_many_html').style.display = 'block'
            document.getElementById('child_many_to_many_html').style.display = 'none'
          } else {
            document.getElementById('child_many_to_many_html').style.display = 'block'
            document.getElementById('parent_many_to_many_html').style.display = 'none'
          }
}

function format_and_capitalize(element_id){
    string = document.getElementById(element_id).value
    capitalized = string.charAt(0).toUpperCase() + string.slice(1);
    formatted = string.split(/(?=[A-Z])/).join(" ")
    return formatted
    // return capitalized 
}

function proper_formatting(string, element){
    format_type = element.classList[1]
    if (format_type == 'singular') {
        return singular_format(string)
    } else if (format_type == 'plural' ){
        return plural_format(string)
    } else if (format_type == 'posessive'){
        return posessive_format(string)
    } else if (format_type == "uri"){
        return uri_format(string)
    } else {
        return string
    }
}

function singular_format(string){
    formatted = string.split(/(?=[A-Z])/).join(" ")
    // capitalized = string.charAt(0).toUpperCase() + string.slice(1).toLowerCase();
    return formatted
}

function plural_format(string){
    split = string.split(/(?=[A-Z])/)
    if (split.length > 1){
        last_word = split[split.length - 1]
        split.pop()
        pluralize_last_word = last_word + 's'
        return split.push(pluralize_last_word).join(" ")
    } else {
        capitalized = string.charAt(0).toUpperCase() + string.slice(1).toLowerCase();
        return capitalized + "s"
    }
}

function posessive_format(string){
    pluralized = plural_format(string)
    position = pluralized.length - 1
    final_format = pluralized.slice(0,position) + "'" + "s"
    return final_format
}

function uri_format(string){
    return plural_format(string).toLowerCase().split(" ").join("_")
}