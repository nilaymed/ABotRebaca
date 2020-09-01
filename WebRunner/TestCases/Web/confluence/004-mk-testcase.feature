



@mediakind-first-testcase

Feature: Login to MediaKind and test RefApp player

Scenario: Login to MediaKind to test RefApp player for testing video playback

  Given I open the Mediakind URL "https://mfuser:Mf!2017@launch.mgmt.tv3cloud.net/"
  And the page loads with the title "MediaFirst Service Center"
  When I open the link "Reach-ProdC-CCX (PC)" in another tab
  And I input the username as "jinadatta@outlook.com" password as "Jina@123"
  Then I go to the RefApp URL "http://192.168.15.113:8090/RefApp/" in another tab
  And I input the testdata there for RefApp player
  And the RefApp player starts for video playback testing
  
