module namespace page = 'http://basex.org/modules/web-page';

import module namespace rest = "http://exquery.org/ns/restxq";
import module namespace db = "http://basex.org/modules/db";

declare
  %rest:path("/dictionary/save-entry")
  %rest:POST
  %rest:form-param("original-orth", "{$original-orth}")
  %rest:form-param("orth", "{$orth}")
  %rest:form-param("phon", "{$phon}")
  %rest:form-param("pos", "{$pos}")
  %rest:form-param("definition_en", "{$definition_en}")
  %rest:form-param("definition_fr", "{$definition_fr}")
  %rest:form-param("definition_sq", "{$definition_sq}")
  %updating
function page:save-entry($original-orth, $orth, $phon, $pos, $definition_en, $definition_fr, $definition_sq) {
  
  let $entry := db:get("DICTIONARY")/bdd/entry[lemma[@n="orth"] = $original-orth]
  let $pos-values := tokenize($pos, ',\s*')
  
  (: Update existing entry :)
  replace value of node $entry/lemma[@n="orth"] with $orth,
  replace value of node $entry/lemma[@n="phon"] with $phon,
  
  (: Update parts of speech :)
  delete node $entry/form/pos,
  insert node (for $p in $pos-values return <pos>{normalize-space($p)}</pos>) into $entry/form,
  
  (: Handling definitions for different languages :)
  (: For legacy entries with a single 'def' element :)
  if (exists($entry/def)) then (
    delete node $entry/def
  ) else (),
  
  (: Update or create English definition :)
  if (exists($entry/def_en)) then (
    replace value of node $entry/def_en with $definition_en
  ) else (
    insert node <def_en>{$definition_en}</def_en> into $entry
  ),
  
  (: Update or create French definition :)
  if (exists($entry/def_fr)) then (
    replace value of node $entry/def_fr with $definition_fr
  ) else (
    insert node <def_fr>{$definition_fr}</def_fr> into $entry
  ),
  
  (: Update or create Albanian definition :)
  if (exists($entry/def_sq)) then (
    replace value of node $entry/def_sq with $definition_sq
  ) else (
    insert node <def_sq>{$definition_sq}</def_sq> into $entry
  )
};

declare
  %rest:path("/dictionary/save-entry")
  %rest:POST
  %output:method("html")
function page:redirect() {
  <rest:response>
    <http:response status="302">
      <http:header name="Location" value="/dictionary/browse"/>
    </http:response>
  </rest:response>
};
