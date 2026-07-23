---
title: cstidy
---

<p class="cs-lede">cstidy puts aggregated disease-surveillance counts into one standard
panel format, and derives the time and geography columns that format needs. Give it a
table with a time column and a <code>location_code</code>; get back the same table with
<code>isoyear</code>, <code>isoweek</code>, <code>season</code>, <code>seasonweek</code>,
<code>date</code> and the granularity columns filled in. It does not aggregate
individual-level records — aggregate first, then use cstidy.</p>

<p class="cs-lede">cstidy is built by <strong>Core Surveillance</strong>, a team at the
Norwegian Institute of Public Health (NIPH; Folkehelseinstituttet, FHI), alongside
<code>cstime</code>, <code>csdata</code>, <code>csalert</code> and <code>csstyle</code>.
The <code>cs</code> prefix is Core Surveillance; the format class
<code>csfmt_rts_data_v3</code> is core surveillance format, real-time surveillance data,
version 3. Defaults follow NIPH convention — a surveillance season runs from ISO week 35
to ISO week 34, and geography codes are Norwegian.</p>

<p class="cs-section">Features</p>

<div class="cs-cards">
<div class="cs-card"><div class="cs-card-num">01</div><h3>Standard data format</h3><p>Apply <code>set_csfmt_rts_data_v3()</code> for the slim weekly format, or <code>set_csfmt_rts_data_v2()</code> for the older 18-column format that also covers daily and yearly data.</p></div>
<div class="cs-card"><div class="cs-card-num">02</div><h3>Smart assignment</h3><p>Assigning <code>isoyear</code>, <code>isoyearweek</code>, <code>date</code>, or <code>location_code</code> with <code>:=</code> automatically re-derives all dependent time and geography columns.</p></div>
<div class="cs-card"><div class="cs-card-num">03</div><h3>Panel inspection</h3><p>Check completeness with <code>unique_time_series()</code>, extend to a future time point with <code>expand_time_to()</code>, and plot column structure with <code>identify_data_structure()</code>.</p></div>
</div>
