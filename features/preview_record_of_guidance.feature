Feature: Record of guidance preview
  As a Pension Wise guider
  I want to preview the record of guidance before it is sent
  So that I can confirm that the documents to be sent are as intended

Scenario: Tailored record of guidance
  Given one or more of the predefined circumstances applies to the customer
  When I preview their record of guidance
  Then the sections that the preview includes should be (in order):
    | introduction                          |
    | pension pot                           |
    | options overview                      |
    | detail about applicable circumstances |
    | other information                     |

Scenario: Generic record of guidance
  Given I don't know that any of the predefined circumstances apply to the customer
  When I preview their record of guidance
  Then the sections that the preview includes should be (in order):
    | introduction             |
    | pension pot              |
    | options overview         |
    | detail about each option |
    | other information        |

Scenario Outline: Guidance is tailored based on applicable circumstances
  Given "<circumstance>" applies to the customer
  When I preview their record of guidance
  Then the preview should include information about "<circumstance>"

  Examples:
    | circumstance                          |
    | Plans to continue working for a while |
    | Unsure about plans in retirement      |
    | Plans to leave money to someone       |
    | Wants flexibility when taking money   |
    | Wants a guaranteed income             |
    | Needs a certain amount of money now   |
    | Has poor health                       |

Scenario Outline: "Pension pot" section is tailored based on the range of income sources available to the customer
  Given the customer has access to income during retirement from <sources-of-income>
  When I preview their record of guidance
  Then the preview should include the "<sources-of-income>" version of the "pension pot" section

  Examples:
    | sources-of-income                   |
    | multiple sources                    |
    | only their DC pot and state pension |

Scenario: Records of guidance include the information provided to us by the customer
  Given I have captured the customer's details in an appointment summary
  When I preview their record of guidance
  Then the record of guidance preview should include their details

Scenario: Records of guidance include information about the appointment
  Given I have captured appointment details in an appointment summary
  When I preview a record of guidance
  Then the record of guidance preview should include the details of the appointment
