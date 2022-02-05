function Set-MDTComputerApplication {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id,
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $applications
    )

    Process
    {
        Set-MDTArray $id 'C' 'Settings_Applications' 'Applications' $applications
    }
}