module namespace page = 'http://basex.org/modules/web-page';

declare
  %rest:path("/dictionary/edit-entry")
  %rest:GET
  %output:method("html")
  %output:doctype-system("about:legacy-compat")
function page:edit() {
  let $id := request:parameter("id")
  let $entry := db:get("DICTIONARY")/bdd/entry[lemma[@n="orth"] = $id]
  
  return
  <html>
    <head>
      <title>Edit Dictionary Entry</title>
      <meta charset="UTF-8"/>
      <style>
        body {{ font-family: Arial, sans-serif; margin: 20px; }}
        .form-group {{ margin-bottom: 15px; }}
        label {{ display: block; margin-bottom: 5px; font-weight: bold; }}
        input, textarea {{ width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 3px; }}
        textarea {{ height: 100px; }}
        button {{ 
          background: #4CAF50; 
          color: white; 
          border: none; 
          padding: 8px 15px;
          cursor: pointer;
          border-radius: 3px;
        }}
      </style>
    </head>
    <body>
      <h1>Edit Dictionary Entry</h1>
      
      <form action="/dictionary/save-entry" method="post">
        <input type="hidden" name="original-orth" value="{$id}"/>
        
        <div class="form-group">
          <label>Orthographic Form:</label>
          <input type="text" name="orth" value="{$entry/lemma[@n="orth"]/text()}"/>
        </div>
        
        <div class="form-group">
          <label>Phonetic Form:</label>
          <input type="text" name="phon" value="{$entry/lemma[@n="phon"]/text()}"/>
        </div>
        
        <div class="form-group">
          <label>Parts of Speech:</label>
          <input type="text" name="pos" value="{string-join($entry/form/pos/text(), ', ')}"/>
        </div>
        
        <div class="form-group">
          <label>Definition:</label>
          <textarea name="definition">{$entry/def/text()}</textarea>
        </div>
        
        <button type="submit">Save Changes</button>
        <button type="button" onclick="window.location.href='/dictionary/browse'">Cancel</button>
      </form>
    </body>
  </html>
};
