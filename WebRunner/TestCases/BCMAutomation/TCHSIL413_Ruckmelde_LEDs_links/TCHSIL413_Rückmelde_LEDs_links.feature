@TCHSIL413
Feature: TCHSIL413_R�ckmelde_LEDs_links

  Scenario: Any change to the seat ventilation LED display (s_sl_vl_led_anzeige) due to a switch-off condition must be sent via CAN for a minimum time of 3 transmission messages
    (message HLR_01: 500ms cycle time) in order to really have the LED status "" in the entire communication path BCM -> KBT -> BCM. From "to consistently communicate"

    Given I create test case as test1 for TCHSIL413_R�ckmelde_LEDs_links
      | parameter | value |
      | Location  | Test  |
    When I initialize the test case with the following attributes from TestCases/BCMAutomation/BCM_Test_Harness/Basic_Template.data
      | parameter      | value                  |
      | Vorbedingung   | {VORBEDINGUNG_VALUE}   |
      | Stimulation    | {STIMULATION_VALUE}    |
      | Klassifikation | {KLASSIFIKATION_VALUE} |
      | Nachbedingung  | {NACHBEDINGUNG_VALUE}  |
      | Varianten      | {VARIANTEN_VALUE}      |
    #### create loop block start (if required) after this line
    Then I iterate the test execution as loopexternal with following attributes
      | parameter | value |
      | Current   |     0 |
      | Start     |     1 |
      | Stop      |     6 |
      | Step      |     1 |
    # Call start file
    Given I start Test_Harness_Start_BCM_Template
    Given I define Serial test subsystem as TestInit with the following inputs for TestInitialization
      | parameter                                | value                                                    |
      | PreConditions_impl.Spaltenueberschriften | LIST{Datum, TCHSIL488_LEDs_links_Keine_Anzeig}           |
      | PreConditions_impl.Tabellenname          | STR{_TCHSIL488_LEDs_links_Keine_Anzeig__TESTKOMMENTARE_} |
      | PreConditions_impl.ClearErrorMemory      | INT{1}                                                   |
      #### create additional Preconditions after this line
      | Kodierungstring schreiben                      | cp_sitzlueftung_vorne_verbaut = 1                        |
      #| Signale setzen							  | set(Name,s_bem_rsm_abschaltstufen < 1)					  |
      | Signale setzen                           | s_sl_vl_em_freigabe = 3                                  |
      | Signale setzen                           | s_sl_vr_em_freigabe = 3                                  |
      | Signale setzen                           | s_klemme_75_msg =1                                       |
      | Transportmodus                           | CONT                                                     |
      | Signale setzen                           | s_crashfall_erkannt = 0                                  |
    Then I close TestInit
    When I define Serial test subsystem as TestEval for TestStepsAndEvaluation
    When I define Serial test subsystem as CaptureKonf with the following inputs for CaptureKonfiguration
      | parameter                        | value                 |
      | InitCapture                      | CONT                  |
      | ConfigureCapture.Interval        | FLOAT{10}             |
      | ConfigureCapture.Downsampling    | INT{1}                |
      | ConfigureCapture.Delay           | FLOAT{1}              |
      | ConfigureCapture.Trigger         | STR{off-on}           |
      | ConfigureCapture.TriggerLevel    | FLOAT{123}            |
      | ConfigureCapture.TriggerEdge     | STR{rising-star-east} |
      | ConfigureCapture.TriggerVariable | ESIGNAL{EvalSignal}   |
      | StartCapture                     | CONT                  |
    Then I close CaptureKonf
    # To add a Stimulate block with parameters use the given below
    When I define Serial test subsystem as Stimulate with the following inputs for Stimulate
      | parameter      | value                            |
      | InitCapture    | CONT                             |
      #### create additional Similations after this line
      | Signale setzen | s_sl_vl_kundenwunsch_stufe = 0   |
      | Signale setzen | s_sl_vl_kundenwunsch_balance = 0 |
      | Signale setzen | s_sl_vr_kundenwunsch_stufe = 0   |
      | Signale setzen | s_sl_vr_kundenwunsch_balance = 0 |
      | Signale setzen | s_sl_vl_kundenwunsch_stufe = 1   |
    Then I close Stimulate
    When I define Serial test subsystem as Auswer_Tung with the following inputs for Auswertung
      | parameter                                          | value                                                      |
      | get_CaptureStatus                                  | CONT                                                       |
      | FetchCaptureData                                   | CONT                                                       |
      | GetSignalFromCaptureResult.CaptureResult           | DICT                                                       |
      | GetSignalFromCaptureResult.SignalName              | STR{EvalSignal}                                            |
      | GetSignalFromCaptureResult.HostName                | STR{HillHost}                                              |
      | GetSignalFromCaptureResult.ForceStrictlyIncreasing | STR{Force}                                                 |
      | GetSignalFromCaptureResult.Signal                  | ESIGNAL{EvalSignal}                                        |
      | AddSignalToReport                                  | CONT                                                       |
      #### create additional Classifications after this line
      | CheckSignalIsEqual                                 | set(Name,s_sl_vl_led_anzeige = 0)                          |
      | CheckSignalIsEqual                                 | set(Name,s_sl_vr_led_anzeige = 0)                          |
      | CheckSignalIsEqual                                 | set(Name,s_sl_vl_led_anzeige = 0)                          |
      | CheckSignalIsEqual                                 | set(Name,s_sl_vr_led_anzeige = 0)                          |
      | CheckSignalIsEqual                                 | set(Name,s_sl_vl_led_anzeige = 0)                          |
      | CheckSignalIsInsideBounds                          | set(Name,s_sl_vl_led_anzeige = s_sl_vl_kundenwunsch_stufe) |
    Then I close Auswer_Tung
    Then I close TestEval
    Given I define Serial test subsystem as TestClean with the following inputs for TestCleanUp
      | parameter           | value |
      | PostConditions_impl | CONT  |
    Then I close TestClean
    Then I stop Test_Harness_Stop_BCM_Template
    #### create loop block end (if required) after this line
    Then I close loopexternal
    Then I end test case
