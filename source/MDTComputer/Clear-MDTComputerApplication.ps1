function Clear-MDTComputerApplication {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id
    )

    Process
    {
        Clear-MDTArray $id 'C' 'Settings_Applications'
    }
}