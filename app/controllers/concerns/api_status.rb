module ApiStatus
  # Not equal to HTTP Response Statuses
  CODES = {
    100 => 'Not Authorised',       # Custom status
    110 => 'User Not Found',
    111 => 'UserOrder Not Found',
    112 => 'User Cannot Invite Himself',
    113 => 'This UserOrder Is Already Referenced For Bonuses',
    200 => 'OK',                   # Typical HTTP status for success
    500 => 'Internal Server Error' # Typical HTTP status for server error
  }
end
