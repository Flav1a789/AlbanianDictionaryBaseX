module namespace page = 'http://basex.org/modules/web-page';

declare
  %rest:path("/dictionary/save-entry")
  %rest:POST
  %rest:form-param("original-orth", "{$original-orth}")
  %rest:form-param("orth", "{$orth}")
  %rest:form-param("phon", "{$phon}")
  %rest:form-param("pos", "{$pos}")
  %rest:form-param("definition", "{$definition}")
function page:save-entry($original-orth, $orth, $phon, $pos, $definition) {
  
  let $entry := db:get("DICTIONARY")/bdd/entry[lemma[@n="orth"] = $original-orth]
  let $pos-values := tokenize($pos, ',\s*')
  
  let $update :=
    if (exists($entry)) then (
      (: Update existing entry :)
      replace value of node $entry/lemma[@n="orth"] with $orth,
      replace value of node $entry/lemma[@n="phon"] with $phon,
      delete node $entry/form/pos,
      insert node (for $p in $pos-values return <pos>{normalize-space($p)}</pos>) into $entry/form,
      replace value of node $entry/def with $definition
    ) else ()
    
  return
    <rest:response>
      <http:response status="302">
        <http:header name="Location" value="/dictionary/browse"/>
      </http:response>
    </rest:response>
};
