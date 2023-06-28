class Form {

    hidden [System.Windows.Forms.Form]$Window

    Form([Hashtable]$Params){
        if($null -eq $Params){ return }

        if($Params.ContainsKey("StartPosition") -and $Params.ContainsKey("BorderStyle")){
            $this.Initialize($Params.ScaleX, $Params.ScaleY, $Params.Text, $Params.StartPosition, $Params.BorderStyle)
        }
        else{
            $this.Initialize($Params.ScaleX, $Params.ScaleY, $Params.Text, "CenterScreen", "FixedDialog")
        }
    }

    Form([int]$ScaleX, [int]$ScaleY, [String]$Text){
        $this.Initialize($ScaleX, $ScaleY, $Text, "CenterScreen", "FixedDialog")
    }

    Form([int]$ScaleX, [int]$ScaleY, [String]$Text, [String]$StartPosition, [String]$BorderStyle){
        $this.Initialize($ScaleX, $ScaleY, $Text, $StartPosition, $BorderStyle)
    }

    [void]Initialize([int]$ScaleX, [int]$ScaleY, [String]$Text, [String]$StartPosition, [String]$BorderStyle){
        # Create a form
        $this.Window = New-Object System.Windows.Forms.Form
        $this.Window.Text = $Text
        $this.Window.Size = New-Object System.Drawing.Size($ScaleX, $ScaleY)
        $this.Window.FormBorderStyle = $BorderStyle
        $this.Window.StartPosition = $StartPosition
    }


    [void]Show(){
        if($null -eq $this.Window){ return }
        $this.Window.ShowDialog()
    }


    # Add's

    #? Label
    [void]AddLabel([Hashtable]$Params){
        if($null -eq $Params){ return }
        $this.AddLabel($Params.Text, $Params.Name, $Params.PositionX, $Params.PositionY, $Params.ScaleX, $Params.ScaleY)
    }
    [void]AddLabel([String]$Text, [String]$Name, [int]$PositionX, [int]$PositionY, [int]$ScaleX, [int]$ScaleY){
        # Create a label
        $Label = New-Object System.Windows.Forms.Label
        $Label.Name = $Name
        $Label.Location = New-Object System.Drawing.Point($PositionX, $PositionY)
        $Label.Size = New-Object System.Drawing.Size($ScaleX, $ScaleY)
        $Label.Text = $Text
        $this.Window.Controls.Add($Label)
    }

    #? Button
    [void]AddButton([Hashtable]$Params){
        if($null -eq $Params){ return }
        $this.AddButton($Params.Text, $Params.Name, $Params.PositionX, $Params.PositionY, $Params.ScaleX, $Params.ScaleY)
    }
    [void]AddButton([String]$Text, [String]$Name, [int]$PositionX, [int]$PositionY, [int]$ScaleX, [int]$ScaleY){
        # Create a button
        $button = New-Object System.Windows.Forms.Button
        $button.Name = $Name
        $button.Location = New-Object System.Drawing.Point($PositionX, $PositionY)
        $button.Size = New-Object System.Drawing.Size($ScaleX, $ScaleY)
        $button.Text = $Text
        $this.Window.Controls.Add($button)
    }

    #? TextBox
    [void]AddTextBox([Hashtable]$Params){
        if($null -eq $Params){ return }
        $this.AddLabel($Params.Name, $Params.PositionX, $Params.PositionY, $Params.ScaleX, $Params.ScaleY)
    }
    [void]AddTextBox([String]$Name, [int]$PositionX, [int]$PositionY, [int]$ScaleX, [int]$ScaleY){
        # Create a text box
        $textBox = New-Object System.Windows.Forms.TextBox
        $textBox.Name = $Name
        $textBox.Location = New-Object System.Drawing.Point($PositionX, $PositionY)
        $textBox.Size = New-Object System.Drawing.Size($ScaleX, $ScaleY)
        $this.Window.Controls.Add($textBox)
    }
    
    #? Click Event
    [void]AddClickEvent([System.Windows.Forms.Control]$ControlElement, [ScriptBlock]$ScriptBlock){
        $ControlElement.Add_Click($ScriptBlock)
    }
    
    
    # Finds
    [System.Windows.Forms.Control]FindObject([String]$Name){
        return $this.Window.Controls.Find($Name, $true)[0]
    }

    [System.Windows.Forms.Control[]]FindObjects([String]$Name){
        return $this.Window.Controls.Find($Name, $true)
    }


    # Getters
    [System.Windows.Forms.Form]GetWindow(){
        return $this.Window
    }


    # Setters
    [void]SetWindow([System.Windows.Forms.Form] $Window){
        $this.Window = $Window
    }


}

function Show-Case1(){
    $FormParams = @{
        ScaleX = 300
        ScaleY = 150
        Text = "Test"
    }
    
    $LabelParams = @{
        PositionX = 10
        PositionY = 10
        ScaleX = 280
        ScaleY = 20
        Text = "Label"
        Name = "Label-140"
    }
    
    $ButtonParams = @{
        PositionX = 10
        PositionY = 30
        ScaleX = 200
        ScaleY = 20
        Text = "Click me"
        Name = "Btn-153"
    }
    
    $Form = New-Object Form($FormParams)
    
    $Form.AddLabel($LabelParams)
    $Form.AddButton($ButtonParams)

    $Button = $Form.FindObject("Btn-153")

    $Form.AddClickEvent($Button, {
        $Form.FindObject("Label-140").Text = "You've sucessfully clicked the button!"
    })
    
    $Form.Show()
}

Show-Case1