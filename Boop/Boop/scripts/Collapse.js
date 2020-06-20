/**
    {
        "api":1,
        "name":"Collapse lines",
        "description":"Removes all linebreaks from your text",
        "author":"Dennis",
        "icon":"table",
        "tags":"strip,remove,collapse,join"
    }
**/

function main(input) {
    let split = input.text.split(/\r\n|\r|\n/)
    input.postInfo(`${split.length} lines collapsed`)
    input.fullText = split.join()
}
