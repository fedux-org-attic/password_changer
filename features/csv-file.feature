Feature: Change passwords via csv file
  As an administrator
  I want to change the password of a lot of users
  In order to make tests running

  Background:
    Given a mocked home directory
    And a user configuration file with:
    """
    """

    @wip
  Scenario: Existing csv file
    Given a file with user identities named "users" with:
    """
    "user1","pw_old","pw_new"
    """
    When I successfully run `pc start --csv-file users.csv`
    Then the output should contain:
    """
    Success
    """
