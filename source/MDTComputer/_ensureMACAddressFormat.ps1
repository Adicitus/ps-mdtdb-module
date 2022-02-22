function _ensureMACAddressFormat {
    param(
        [string]$MacAddress
    )

    switch -Regex ($macAddress) {
        # MAC Address without separators
        '([0-9A-F]{2}){6}' {
            $m = $macAddress
            for($i = 10; $i -gt 0; $i = $i -2) {
                $m = $m.insert($i, ':')
            }
            return $m
        }
        
        # MAC Address with '-' as separator:
        '([0-9A-F]{2}-){5}[0-9A-F]{2}' {
            return $macAddress.replace('-', ':')
        }

        # MAC Address with ':' as separator:
        '([0-9A-F]{2}:){5}[0-9A-F]{2}' {
            return $MacAddress
        }

        default {
            throw new Exception("Invalid MacAddress provided: '$MacAddress'.")
        }

    }
}