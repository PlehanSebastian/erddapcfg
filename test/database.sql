
CREATE TABLE IF NOT EXISTS params (
    param_name TEXT PRIMARY KEY NOT NULL,
    param_value TEXT DEFAULT ''
);

CREATE TABLE IF NOT EXISTS datasets (
    dataset_id TEXT PRIMARY KEY NOT NULL,
    dataset_type TEXT NOT NULL,
    dataset_active TEXT CHECK(dataset_active='true' or dataset_active='false') NOT NULL DEFAULT 'false'
);

CREATE TABLE IF NOT EXISTS dataset_children (
    parent_dataset_id TEXT NOT NULL,
    child_dataset_id TEXT NOT NULL,
    FOREIGN KEY(parent_dataset_id) REFERENCES datasets(dataset_id),
    FOREIGN KEY(child_dataset_id) REFERENCES datasets(dataset_id)
);

CREATE TABLE IF NOT EXISTS dataset_params (
    param_name TEXT NOT NULL,
    param_value TEXT DEFAULT '',
    dataset_id TEXT NOT NULL,
    PRIMARY KEY (param_name, dataset_id),
    FOREIGN KEY(dataset_id) REFERENCES datasets(dataset_id)
);

CREATE TABLE IF NOT EXISTS dataset_attributes (
    attribute_name TEXT NOT NULL,
    attribute_type TEXT DEFAULT '',
    attribute_value TEXT DEFAULT '',
    dataset_id TEXT NOT NULL,
    PRIMARY KEY (attribute_name, dataset_id),
    FOREIGN KEY(dataset_id) REFERENCES datasets(dataset_id)
);

CREATE TABLE IF NOT EXISTS dataset_source_attributes (
    attribute_name TEXT NOT NULL,
    attribute_type TEXT DEFAULT '',
    attribute_value TEXT DEFAULT '',
    dataset_id TEXT NOT NULL,
    PRIMARY KEY (attribute_name, dataset_id),
    FOREIGN KEY(dataset_id) REFERENCES datasets(dataset_id)
);

CREATE TABLE IF NOT EXISTS variables (
    variable_id INTEGER PRIMARY KEY NOT NULL,
    category TEXT CHECK(category='data' or category='axis') DEFAULT 'data',
    source_name TEXT NOT NULL,
    destination_name TEXT NOT NULL,
    data_type TEXT NOT NULL,
    dataset_id TEXT NOT NULL,
    order_number REAL NOT NULL DEFAULT 0,
    FOREIGN KEY(dataset_id) REFERENCES datasets(dataset_id)
);

CREATE TABLE IF NOT EXISTS variable_attributes (
    attribute_name TEXT NOT NULL,
    attribute_type TEXT DEFAULT '',
    attribute_value TEXT DEFAULT '',
    variable_id INTEGER NOT NULL,
    PRIMARY KEY (attribute_name, variable_id),
    FOREIGN KEY(variable_id) REFERENCES variables(variable_id)
);

CREATE TABLE IF NOT EXISTS variable_source_attributes (
    attribute_name TEXT NOT NULL,
    attribute_type TEXT DEFAULT '',
    attribute_value TEXT DEFAULT '',
    variable_id INTEGER NOT NULL,
    PRIMARY KEY (attribute_name, variable_id),
    FOREIGN KEY(variable_id) REFERENCES variables(variable_id)
);


-- table params
 INSERT INTO params(param_name, param_value) VALUES
  ("cacheMinutes", ""),
  ("decompressedCacheMaxGB", ""),
  ("decompressedCacheMaxMinutesOld", ""),
  ("drawLandMask", ""),
  ("emailDiagnosticsToErdData", ""),
  ("graphBackgroundColor", ""),
  ("ipAddressMaxRequests", ""),
  ("ipAddressMaxRequestsActive", ""),
  ("ipAddressUnlimited", ""),
  ("loadDatasetsMinMinutes", ""),
  ("loadDatasetsMaxMinutes", ""),
  ("logLevel", ""),
  ("nGridThreads", ""),
  ("nTableThreads", ""),
  ("partialRequestMaxBytes", ""),
  ("partialRequestMaxCells", ""),
  ("slowDownTroubleMillis", ""),
  ("unusualActivity", ""),
  ("updateMaxEvents", ""),
  ("unusualActivityFailPercent", "25"),
  ("startHeadHtml5", ""),
  ("endBodyHtml5", ""),
  ("standardLicense", ""),
  ("standardContact", ""),
  ("standardDataLicenses", ""),
  ("standardDisclaimerOfEndorsement", ""),
  ("standardDisclaimerOfExternalLinks", ""),
  ("standardGeneralDisclaimer", ""),
  ("standardPrivacyPolicy", "::CDATA_START
<br>&nbsp;
<hr>
<h2><a class=""selfLink"" id=""privacyPolicy"" href=""#privacyPolicy"" rel=""help"">Privacy Policy</a></h2>
ERDDAP follows 
<a rel=""bookmark"" href=""https://www.noaa.gov/protecting-your-privacy""
  >NOAA's Privacy Policy Guidelines</a>.
::CDATA_STOP"),
  ("startBodyHtml5", "::CDATA_START
<body>
<table class=""compact nowrap"" style=""width:100%; background-color:#128CB5;"">
  <tr> 
    <td style=""text-align:center; width:80px;""><a rel=""bookmark""
      href=""https://www.noaa.gov/""><img 
      title=""National Oceanic and Atmospheric Administration"" 
      src=""&erddapUrl;/images/noaab.png"" alt=""NOAA""
      style=""vertical-align:middle;""></a></td> 
    <td style=""text-align:left; font-size:x-large; color:#FFFFFF; "">
      <strong>ERDDAP</strong>
      <br><small><small><small>&EasierAccessToScientificData;</small></small></small>
      </td> 
    <td style=""text-align:right; font-size:small;""> 
      &loginInfo; | &language; &nbsp; &nbsp;
      <br>&BroughtToYouBy; 
      <a title=""National Oceanic and Atmospheric Administration"" rel=""bookmark""
      href=""https://www.noaa.gov"">NOAA</a>  
      <a title=""National Marine Fisheries Service"" rel=""bookmark""
      href=""https://www.fisheries.noaa.gov"">NMFS</a>  
      <a title=""Southwest Fisheries Science Center"" rel=""bookmark""
      href=""https://www.fisheries.noaa.gov/about/southwest-fisheries-science-center"">SWFSC</a> 
      <a title=""Environmental Research Division"" rel=""bookmark""
      href=""https://www.fisheries.noaa.gov/about/environmental-research-division-southwest-fisheries-science-center"">ERD</a>  
      &nbsp; &nbsp;
      </td> 
  </tr> 
</table>
::CDATA_STOP"),
  ("theShortDescriptionHtml", "::CDATA_START 
<h1>ERDDAP</h1>
&erddapIs;
&thisParticularErddap;
[standardShortDescriptionHtml]
::CDATA_STOP"),
  ("requestBlacklist", ""),
  ("subscriptionEmailBlacklist", "your.email@yourinstitution.edu, some.name@company.com, 
another.name@company.com, *@example.com");



-- table datasets
 INSERT INTO datasets(dataset_id, dataset_type, dataset_active) VALUES
  ("erdMH1chla1dayTDS", "EDDGridFromDap", "true"),
  ("ndbcSosWTemp", "EDDTableFromSOS", "true"),
  ("jplG1SST", "EDDGridFromErddap", "true"),
  ("jplMURSST41", "EDDGridFromErddap", "true"),
  ("erdNavgem05D10mWind_LonPM180", "EDDGridFromErddap", "true"),
  ("erdNavgem05D20mWind_LonPM180", "EDDGridFromErddap", "true"),
  ("erdNavgem05D500mb_LonPM180", "EDDGridFromErddap", "true"),
  ("erdNavgem05DPres_LonPM180", "EDDGridFromErddap", "true"),
  ("ncdcOw6hr_LonPM180", "EDDGridFromErddap", "true"),
  ("ncdcOwClm9505_LonPM180", "EDDGridFromErddap", "true"),
  ("ncdcOwDly_LonPM180", "EDDGridFromErddap", "true"),
  ("ncdcOwMon_LonPM180", "EDDGridFromErddap", "true"),
  ("ncdcOwDlyStrs_LonPM180", "EDDGridFromErddap", "true"),
  ("ncdcOwMonStrs_LonPM180", "EDDGridFromErddap", "true"),
  ("erdMH1cflh1day", "EDDGridFromErddap", "true"),
  ("erdMH1cflh8day", "EDDGridFromErddap", "true"),
  ("erdMH1cflhmday", "EDDGridFromErddap", "true"),
  ("erdMH1chla1day", "EDDGridFromErddap", "true"),
  ("erdMH1chla8day", "EDDGridFromErddap", "true"),
  ("erdMH1chlamday", "EDDGridFromErddap", "true"),
  ("erdMH1kd4901day", "EDDGridFromErddap", "true"),
  ("erdMH1kd4908day", "EDDGridFromErddap", "true"),
  ("erdMH1kd490mday", "EDDGridFromErddap", "true"),
  ("erdMH1par01day", "EDDGridFromErddap", "true"),
  ("erdMH1par08day", "EDDGridFromErddap", "true"),
  ("erdMH1par0mday", "EDDGridFromErddap", "true"),
  ("erdVH2018chla1day", "EDDGridFromErddap", "true"),
  ("erdVH2018chla8day", "EDDGridFromErddap", "true"),
  ("erdVH2018chlamday", "EDDGridFromErddap", "true"),
  ("erdVH2018k4901day", "EDDGridFromErddap", "true"),
  ("erdVH2018k4908day", "EDDGridFromErddap", "true"),
  ("erdVH2018k490mday", "EDDGridFromErddap", "true"),
  ("erdVH2018par1day", "EDDGridFromErddap", "true"),
  ("erdVH2018par8day", "EDDGridFromErddap", "true"),
  ("erdVH2018parmday", "EDDGridFromErddap", "true"),
  ("erdVH2018pic1day", "EDDGridFromErddap", "true"),
  ("erdVH2018pic8day", "EDDGridFromErddap", "true"),
  ("erdVH2018picmday", "EDDGridFromErddap", "true"),
  ("erdVH2018poc1day", "EDDGridFromErddap", "true"),
  ("erdVH2018poc8day", "EDDGridFromErddap", "true"),
  ("erdVH2018pocmday", "EDDGridFromErddap", "true"),
  ("erdVH2018r6711day", "EDDGridFromErddap", "true"),
  ("erdVH2018r6718day", "EDDGridFromErddap", "true"),
  ("erdVH2018r671mday", "EDDGridFromErddap", "true"),
  ("jplAquariusSSS3MonthV5", "EDDGridFromErddap", "true"),
  ("jplAquariusSSS7DayV5", "EDDGridFromErddap", "true"),
  ("jplAquariusSSSDailyV5", "EDDGridFromErddap", "true"),
  ("jplAquariusSSSMonthlyV5", "EDDGridFromErddap", "true"),
  ("cwwcNDBCMet", "EDDTableFromErddap", "true"),
  ("erdGtsppBest", "EDDTableFromErddap", "true"),
  ("pmelTaoDyAdcp", "EDDTableFromErddap", "true"),
  ("pmelTaoDyAirt", "EDDTableFromErddap", "true"),
  ("pmelTaoDyBf", "EDDTableFromErddap", "true"),
  ("pmelTaoDyBp", "EDDTableFromErddap", "true"),
  ("pmelTaoDyCur", "EDDTableFromErddap", "true"),
  ("pmelTaoDyD", "EDDTableFromErddap", "true"),
  ("pmelTaoDyDyn", "EDDTableFromErddap", "true"),
  ("pmelTaoDyEmp", "EDDTableFromErddap", "true"),
  ("pmelTaoDyEvap", "EDDTableFromErddap", "true"),
  ("pmelTaoDyHeat", "EDDTableFromErddap", "true"),
  ("pmelTaoDyIso", "EDDTableFromErddap", "true"),
  ("pmelTaoDyLw", "EDDTableFromErddap", "true"),
  ("pmelTaoDyLwnet", "EDDTableFromErddap", "true"),
  ("pmelTaoDyPos", "EDDTableFromErddap", "true"),
  ("pmelTaoDyQlat", "EDDTableFromErddap", "true"),
  ("pmelTaoDyQnet", "EDDTableFromErddap", "true"),
  ("pmelTaoDyQsen", "EDDTableFromErddap", "true"),
  ("pmelTaoDyRad", "EDDTableFromErddap", "true"),
  ("pmelTaoDyRain", "EDDTableFromErddap", "true"),
  ("pmelTaoDyRf", "EDDTableFromErddap", "true"),
  ("pmelTaoDyRh", "EDDTableFromErddap", "true"),
  ("pmelTaoDyS", "EDDTableFromErddap", "true"),
  ("pmelTaoDySsd", "EDDTableFromErddap", "true"),
  ("pmelTaoDySss", "EDDTableFromErddap", "true"),
  ("pmelTaoDySst", "EDDTableFromErddap", "true"),
  ("pmelTaoDySwnet", "EDDTableFromErddap", "true"),
  ("pmelTaoDyT", "EDDTableFromErddap", "true"),
  ("pmelTaoDyTau", "EDDTableFromErddap", "true"),
  ("pmelTaoDyW", "EDDTableFromErddap", "true"),
  ("erdMWchla1day", "EDDGridFromErddap", "true"),
  ("rlPmelTaoDySst", "EDDTableFromErddap", "true");



-- table dataset_params
 INSERT INTO dataset_params ("param_name", "param_value", "dataset_id") VALUES
  ("sourceUrl", "https://oceanwatch.pfeg.noaa.gov/thredds/dodsC/satellite/MH1/chla/1day", "erdMH1chla1dayTDS"),
  ("reloadEveryNMinutes", "240", "erdMH1chla1dayTDS"),
  ("sourceUrl", "http://sdf.ndbc.noaa.gov/sos/server.php", "ndbcSosWTemp"),
  ("sosVersion", "1.0.0", "ndbcSosWTemp"),
  ("sosServerType", "IOOS_NDBC", "ndbcSosWTemp"),
  ("reloadEveryNMinutes", "1440", "ndbcSosWTemp"),
  ("observationOfferingIdRegex", ".+", "ndbcSosWTemp"),
  ("requestObservedPropertiesSeparately", "true", "ndbcSosWTemp"),
  ("bboxOffering", "urn:ioos:network:noaa.nws.ndbc:all", "ndbcSosWTemp"),
  ("bboxParameter", "featureofinterest=BBOX:", "ndbcSosWTemp"),
  ("longitudeSourceName", "longitude (degree)", "ndbcSosWTemp"),
  ("latitudeSourceName", "latitude (degree)", "ndbcSosWTemp"),
  ("altitudeSourceName", "depth (m)", "ndbcSosWTemp"),
  ("altitudeMetersPerSourceUnit", "-1", "ndbcSosWTemp"),
  ("timeSourceName", "date_time", "ndbcSosWTemp"),
  ("timeSourceFormat", "yyyy-MM-dd'T'HH:mm:ssZ", "ndbcSosWTemp"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/jplG1SST", "jplG1SST"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/jplMURSST41", "jplMURSST41"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdNavgem05D10mWind_LonPM180", "erdNavgem05D10mWind_LonPM180"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdNavgem05D20mWind_LonPM180", "erdNavgem05D20mWind_LonPM180"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdNavgem05D500mb_LonPM180", "erdNavgem05D500mb_LonPM180"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdNavgem05DPres_LonPM180", "erdNavgem05DPres_LonPM180"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/ncdcOw6hr_LonPM180", "ncdcOw6hr_LonPM180"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/ncdcOwClm9505_LonPM180", "ncdcOwClm9505_LonPM180"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/ncdcOwDly_LonPM180", "ncdcOwDly_LonPM180"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/ncdcOwMon_LonPM180", "ncdcOwMon_LonPM180"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/ncdcOwDlyStrs_LonPM180", "ncdcOwDlyStrs_LonPM180"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/ncdcOwMonStrs_LonPM180", "ncdcOwMonStrs_LonPM180"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdMH1cflh1day", "erdMH1cflh1day"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdMH1cflh8day", "erdMH1cflh8day"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdMH1cflhmday", "erdMH1cflhmday"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdMH1chla1day", "erdMH1chla1day"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdMH1chla8day", "erdMH1chla8day"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdMH1chlamday", "erdMH1chlamday"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdMH1kd4901day", "erdMH1kd4901day"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdMH1kd4908day", "erdMH1kd4908day"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdMH1kd490mday", "erdMH1kd490mday"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdMH1par01day", "erdMH1par01day"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdMH1par08day", "erdMH1par08day"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdMH1par0mday", "erdMH1par0mday"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdVH2018chla1day", "erdVH2018chla1day"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdVH2018chla8day", "erdVH2018chla8day"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdVH2018chlamday", "erdVH2018chlamday"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdVH2018k4901day", "erdVH2018k4901day"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdVH2018k4908day", "erdVH2018k4908day"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdVH2018k490mday", "erdVH2018k490mday"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdVH2018par1day", "erdVH2018par1day"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdVH2018par8day", "erdVH2018par8day"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdVH2018parmday", "erdVH2018parmday"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdVH2018pic1day", "erdVH2018pic1day"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdVH2018pic8day", "erdVH2018pic8day"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdVH2018picmday", "erdVH2018picmday"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdVH2018poc1day", "erdVH2018poc1day"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdVH2018poc8day", "erdVH2018poc8day"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdVH2018pocmday", "erdVH2018pocmday"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdVH2018r6711day", "erdVH2018r6711day"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdVH2018r6718day", "erdVH2018r6718day"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdVH2018r671mday", "erdVH2018r671mday"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/jplAquariusSSS3MonthV5", "jplAquariusSSS3MonthV5"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/jplAquariusSSS7DayV5", "jplAquariusSSS7DayV5"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/jplAquariusSSSDailyV5", "jplAquariusSSSDailyV5"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/jplAquariusSSSMonthlyV5", "jplAquariusSSSMonthlyV5"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/cwwcNDBCMet", "cwwcNDBCMet"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/erdGtsppBest", "erdGtsppBest"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/pmelTaoDyAdcp", "pmelTaoDyAdcp"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/pmelTaoDyAirt", "pmelTaoDyAirt"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/pmelTaoDyBf", "pmelTaoDyBf"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/pmelTaoDyBp", "pmelTaoDyBp"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/pmelTaoDyCur", "pmelTaoDyCur"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/pmelTaoDyD", "pmelTaoDyD"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/pmelTaoDyDyn", "pmelTaoDyDyn"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/pmelTaoDyEmp", "pmelTaoDyEmp"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/pmelTaoDyEvap", "pmelTaoDyEvap"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/pmelTaoDyHeat", "pmelTaoDyHeat"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/pmelTaoDyIso", "pmelTaoDyIso"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/pmelTaoDyLw", "pmelTaoDyLw"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/pmelTaoDyLwnet", "pmelTaoDyLwnet"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/pmelTaoDyPos", "pmelTaoDyPos"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/pmelTaoDyQlat", "pmelTaoDyQlat"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/pmelTaoDyQnet", "pmelTaoDyQnet"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/pmelTaoDyQsen", "pmelTaoDyQsen"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/pmelTaoDyRad", "pmelTaoDyRad"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/pmelTaoDyRain", "pmelTaoDyRain"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/pmelTaoDyRf", "pmelTaoDyRf"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/pmelTaoDyRh", "pmelTaoDyRh"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/pmelTaoDyS", "pmelTaoDyS"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/pmelTaoDySsd", "pmelTaoDySsd"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/pmelTaoDySss", "pmelTaoDySss"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/pmelTaoDySst", "pmelTaoDySst"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/pmelTaoDySwnet", "pmelTaoDySwnet"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/pmelTaoDyT", "pmelTaoDyT"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/pmelTaoDyTau", "pmelTaoDyTau"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/tabledap/pmelTaoDyW", "pmelTaoDyW"),
  ("sourceUrl", "https://coastwatch.pfeg.noaa.gov/erddap/griddap/erdMWchla1day", "erdMWchla1day"),
  ("sourceUrl", "http://localhost:8080/erddap/tabledap/pmelTaoDySst", "rlPmelTaoDySst");



-- table dataset_params
 INSERT INTO dataset_attributes ("attribute_name", "attribute_type", "attribute_value", "dataset_id") VALUES
  ("Conventions", "", "CF-1.6, COARDS, ACDD-1.3", "erdMH1chla1dayTDS"),
  ("creator_type", "", "group", "erdMH1chla1dayTDS"),
  ("creator_url", "", "https://oceandata.sci.gsfc.nasa.gov", "erdMH1chla1dayTDS"),
  ("data_bins", "", "null", "erdMH1chla1dayTDS"),
  ("data_maximum", "", "null", "erdMH1chla1dayTDS"),
  ("data_minimum", "", "null", "erdMH1chla1dayTDS"),
  ("easternmost_longitude", "", "null", "erdMH1chla1dayTDS"),
  ("end_orbit_number", "", "null", "erdMH1chla1dayTDS"),
  ("history", "", "Files downloaded daily from https://oceandata.sci.gsfc.nasa.gov/MODIS-Aqua/L3SMI to NOAA SWFSC ERD (erd.data@noaa.gov)
ERD uses .ncml to add a time dimension.
Direct read of HDF4 file through CDM library", "erdMH1chla1dayTDS"),
  ("id", "", "null", "erdMH1chla1dayTDS"),
  ("identifier_product_doi_authority", "", "https://dx.doi.org", "erdMH1chla1dayTDS"),
  ("infoUrl", "", "https://coastwatch.pfeg.noaa.gov/infog/MH1_chla_las.html", "erdMH1chla1dayTDS"),
  ("institution", "", "NOAA NMFS SWFSC ERD", "erdMH1chla1dayTDS"),
  ("keywords", "", "algorithm, biology, center, chemistry, chlor_a, chlorophyll, color, concentration, data, ecology, flight, goddard, group, gsfc, image, imaging, L3, laboratory, level, level-3, mapped, mass, mass_concentration_chlorophyll_concentration_in_sea_water, moderate, modis, nasa, ocean, ocean color, oceans,
Earth Science > Oceans > Ocean Chemistry > Chlorophyll; Oceans > Ocean Optics > Ocean Color,
oci, optics, processing, resolution, sea, seawater, smi, space, spectroradiometer, standard, time, water", "erdMH1chla1dayTDS"),
  ("keywords_vocabulary", "", "GCMD Science Keywords", "erdMH1chla1dayTDS"),
  ("latitude_step", "", "null", "erdMH1chla1dayTDS"),
  ("latitude_units", "", "null", "erdMH1chla1dayTDS"),
  ("license", "", "https://science.nasa.gov/earth-science/earth-science-data/data-information-policy/
[standard]", "erdMH1chla1dayTDS"),
  ("longitude_step", "", "null", "erdMH1chla1dayTDS"),
  ("longitude_units", "", "null", "erdMH1chla1dayTDS"),
  ("Metadata_Conventions", "", "null", "erdMH1chla1dayTDS"),
  ("naming_authority", "", "gov.noaa.pfeg.coastwatch", "erdMH1chla1dayTDS"),
  ("northernmost_latitude", "", "null", "erdMH1chla1dayTDS"),
  ("number_of_columns", "", "null", "erdMH1chla1dayTDS"),
  ("number_of_lines", "", "null", "erdMH1chla1dayTDS"),
  ("publisher_email", "", "erd.data@noaa.gov", "erdMH1chla1dayTDS"),
  ("publisher_name", "", "NOAA NMFS SWFSC ERD", "erdMH1chla1dayTDS"),
  ("publisher_type", "", "institution", "erdMH1chla1dayTDS"),
  ("publisher_url", "", "https://www.pfeg.noaa.gov", "erdMH1chla1dayTDS"),
  ("southernmost_latitude", "", "null", "erdMH1chla1dayTDS"),
  ("standard_name_vocabulary", "", "CF Standard Name Table v29", "erdMH1chla1dayTDS"),
  ("start_orbit_number", "", "null", "erdMH1chla1dayTDS"),
  ("suggested_image_scaling_applied", "", "null", "erdMH1chla1dayTDS"),
  ("suggested_image_scaling_maximum", "", "null", "erdMH1chla1dayTDS"),
  ("suggested_image_scaling_minimum", "", "null", "erdMH1chla1dayTDS"),
  ("suggested_image_scaling_type", "", "null", "erdMH1chla1dayTDS"),
  ("sw_point_latitude", "", "null", "erdMH1chla1dayTDS"),
  ("sw_point_longitude", "", "null", "erdMH1chla1dayTDS"),
  ("summary", "", "This dataset has Level 3, Standard Mapped Image, 4km, chlorophyll-a concentration data from NASA's Aqua Spacecraft.  Measurements are gathered by the Moderate Resolution Imaging Spectroradiometer (MODIS) carried aboard the spacecraft.  This is Science Quality data.  This is the August 2015 version of this dataset.", "erdMH1chla1dayTDS"),
  ("testOutOfDate", "", "now-3days", "erdMH1chla1dayTDS"),
  ("title", "", "Chlorophyll-a, Aqua MODIS, NPP, L3SMI, Global, 4km, Science Quality, 2003-present (1 Day Composite)", "erdMH1chla1dayTDS"),
  ("westernmost_longitude", "", "null", "erdMH1chla1dayTDS"),
  ("cdm_data_type", "", "TimeSeries", "ndbcSosWTemp"),
  ("cdm_timeseries_variables", "", "station_id, longitude, latitude, sensor_id", "ndbcSosWTemp"),
  ("Conventions", "", "COARDS, CF-1.6, ACDD-1.3", "ndbcSosWTemp"),
  ("Metadata_Conventions", "", "null", "ndbcSosWTemp"),
  ("infoUrl", "", "http://sdf.ndbc.noaa.gov/sos/", "ndbcSosWTemp"),
  ("institution", "", "NOAA NDBC", "ndbcSosWTemp"),
  ("keywords", "", "
Earth Science > Atmosphere > Altitude > Station Height,
Earth Science > Oceans > Ocean Temperature > Water Temperature,
altitude, atmosphere, height, identifier, ndbc, noaa, ocean, oceans, sea, sea_water_temperature, seawater, sensor, sos, station, temperature, time, water", "ndbcSosWTemp"),
  ("keywords_vocabulary", "", "GCMD Science Keywords", "ndbcSosWTemp"),
  ("license", "", "[standard]", "ndbcSosWTemp"),
  ("standard_name_vocabulary", "", "CF Standard Name Table v29", "ndbcSosWTemp"),
  ("summary", "", "The NOAA NDBC SOS server is part of the IOOS DIF SOS Project.  The stations in this dataset have sea_water_temperature data.

Because of the nature of SOS requests, requests for data MUST include constraints for the longitude, latitude, time, and/or station_id variables.", "ndbcSosWTemp"),
  ("title", "", "NOAA NDBC SOS, 2006-present, sea_water_temperature", "ndbcSosWTemp");





-- table variables
 INSERT INTO variables ("category", "source_name", "destination_name", "data_type", "dataset_id", "order_number") VALUES
  ("data", "MHchla", "chlorophyll", "None", "erdMH1chla1dayTDS", "10.0"),
  ("axis", "time", "time", "None", "erdMH1chla1dayTDS", "20.0"),
  ("axis", "latitude", "latitude", "None", "erdMH1chla1dayTDS", "30.0"),
  ("axis", "longitude", "longitude", "None", "erdMH1chla1dayTDS", "40.0"),
  ("data", "sensor_id", "None", "String", "ndbcSosWTemp", "50.0"),
  ("data", "sea_water_temperature (C)", "sea_water_temperature", "float", "ndbcSosWTemp", "60.0");



-- table variable_attributes
 INSERT INTO variable_attributes ("attribute_name", "attribute_type", "attribute_value", "variable_id") VALUES 
  ("colorBarMaximum", "double", "30.0", (SELECT variable_id FROM variables WHERE destination_name='chlorophyll' AND dataset_id='erdMH1chla1dayTDS')),
  ("colorBarMinimum", "double", "0.03", (SELECT variable_id FROM variables WHERE destination_name='chlorophyll' AND dataset_id='erdMH1chla1dayTDS')),
  ("colorBarScale", "", "Log", (SELECT variable_id FROM variables WHERE destination_name='chlorophyll' AND dataset_id='erdMH1chla1dayTDS')),
  ("ioos_category", "", "Ocean Color", (SELECT variable_id FROM variables WHERE destination_name='chlorophyll' AND dataset_id='erdMH1chla1dayTDS')),
  ("units", "", "mg m-3", (SELECT variable_id FROM variables WHERE destination_name='chlorophyll' AND dataset_id='erdMH1chla1dayTDS')),
  ("ioos_category", "", "Time", (SELECT variable_id FROM variables WHERE destination_name='time' AND dataset_id='erdMH1chla1dayTDS')),
  ("ioos_category", "", "Location", (SELECT variable_id FROM variables WHERE destination_name='latitude' AND dataset_id='erdMH1chla1dayTDS')),
  ("long_name", "", "Latitude", (SELECT variable_id FROM variables WHERE destination_name='latitude' AND dataset_id='erdMH1chla1dayTDS')),
  ("ioos_category", "", "Location", (SELECT variable_id FROM variables WHERE destination_name='longitude' AND dataset_id='erdMH1chla1dayTDS')),
  ("long_name", "", "Longitude", (SELECT variable_id FROM variables WHERE destination_name='longitude' AND dataset_id='erdMH1chla1dayTDS')),
  ("comment", "", "Always check the quality_flags before using this data.", (SELECT variable_id FROM variables WHERE destination_name='None' AND dataset_id='ndbcSosWTemp')),
  ("ioos_category", "", "Identifier", (SELECT variable_id FROM variables WHERE destination_name='None' AND dataset_id='ndbcSosWTemp')),
  ("long_name", "", "Sensor ID", (SELECT variable_id FROM variables WHERE destination_name='None' AND dataset_id='ndbcSosWTemp')),
  ("observedProperty", "", "http://mmisw.org/ont/cf/parameter/sea_water_temperature", (SELECT variable_id FROM variables WHERE destination_name='None' AND dataset_id='ndbcSosWTemp')),
  ("colorBarMinimum", "double", "0", (SELECT variable_id FROM variables WHERE destination_name='sea_water_temperature' AND dataset_id='ndbcSosWTemp')),
  ("colorBarMaximum", "double", "32", (SELECT variable_id FROM variables WHERE destination_name='sea_water_temperature' AND dataset_id='ndbcSosWTemp')),
  ("ioos_category", "", "Temperature", (SELECT variable_id FROM variables WHERE destination_name='sea_water_temperature' AND dataset_id='ndbcSosWTemp')),
  ("long_name", "", "Sea Water Temperature", (SELECT variable_id FROM variables WHERE destination_name='sea_water_temperature' AND dataset_id='ndbcSosWTemp')),
  ("observedProperty", "", "http://mmisw.org/ont/cf/parameter/sea_water_temperature", (SELECT variable_id FROM variables WHERE destination_name='sea_water_temperature' AND dataset_id='ndbcSosWTemp')),
  ("standard_name", "", "sea_water_temperature", (SELECT variable_id FROM variables WHERE destination_name='sea_water_temperature' AND dataset_id='ndbcSosWTemp')),
  ("units", "", "degree_C", (SELECT variable_id FROM variables WHERE destination_name='sea_water_temperature' AND dataset_id='ndbcSosWTemp'));




