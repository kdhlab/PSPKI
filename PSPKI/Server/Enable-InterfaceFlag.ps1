function Enable-InterfaceFlag {
<#
.ExternalHelp PSPKI.Help.xml
#>
[OutputType('PKI.CertificateServices.Flags.InterfaceFlag[]')]
[CmdletBinding()]
	param(
		[Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
		[PKI.CertificateServices.Flags.InterfaceFlag[]]$InputObject,
		[Parameter(Mandatory = $true)]
		[PKI.CertificateServices.Flags.InterfaceFlagEnum]$Flag,
		[switch]$RestartCA
	)
	process {
		foreach ($InterfaceFlag in $InputObject) {
			try {
				$InterfaceFlag.Add($Flag)
				$Status = $InterfaceFlag.SetInfo($RestartCA)
				if ($Status) {
					if (!$RestartCA) {Write-Verbose ($RestartRequired -f "management interface settings")}
				} else {Write-Verbose $NothingIsSet}
				$InterfaceFlag
			} finally { }
		}
	}
}