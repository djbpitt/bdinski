<?xml version="1.0" encoding="UTF-8"?>
<!--
  bdinski.sch
  David J. Birnbaum (djbpitt@gmail.com)
  Project home: http://bdinski.obdurodon.org
  
  2012-12-10: First version. Ensures that <start> is located on the first folio
  2014:02-05: Ensures that <end> is located on the last folio

-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <pattern>
    <rule context="root">
      <assert test="count(start) eq 1">There must be exactly one "start" element.</assert>
      <assert test="count(end) eq 1">There must be exactly one "end" element.</assert>
    </rule>
    <rule context="start">
      <assert test="count(preceding-sibling::folio) eq 1">The "start" element must follow the first
        "folio" element.</assert>
    </rule>
    <rule context="end">
      <assert test="count(following-sibling::folio) eq 0">The "end" element must follow the last
        "folio" element.</assert>
    </rule>
  </pattern>
</schema>
