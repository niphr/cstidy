---
title: cstidy
---

<p class="cs-section">Features</p>

<div class="cs-cards">
<div class="cs-card"><div class="cs-card-num">01</div><h3>Standard data format</h3><p>Apply <code>set_csfmt_rts_data_v2()</code> to stamp a dataset with the 18-column panel format used across Core Surveillance real-time pipelines.</p></div>
<div class="cs-card"><div class="cs-card-num">02</div><h3>Smart assignment</h3><p>Assigning <code>isoyear</code>, <code>isoyearweek</code>, <code>date</code>, or <code>location_code</code> with <code>:=</code> automatically fills all dependent time and geography columns.</p></div>
<div class="cs-card"><div class="cs-card-num">03</div><h3>Panel inspection</h3><p>Check completeness with <code>unique_time_series()</code>, extend to a future time point with <code>expand_time_to()</code>, and plot column structure with <code>identify_data_structure()</code>.</p></div>
</div>

## Overview 

[cstidy](https://niphr.github.io/cstidy/) contains helpful functions for the cleaning and manipulation of surveillance data, especially with regards to the creation and validation of panel data from individual level surveillance data.

Read the introduction vignette [here](https://niphr.github.io/cstidy/articles/cstidy.html) or run `help(package="cstidy")`.
