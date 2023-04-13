//
//  ViewController.swift
//  ControlesYvistasTexto
//
//  Created by Eva Lopez Marquez on 11/4/23.
//

import UIKit


class ViewController: UIViewController {
    
    // Outlets = componentes
    // (=> Referencia directa al elemento de vista)
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var myPickerView: UIPickerView!
    @IBOutlet weak var mypagecontrol: UIPageControl!
    @IBOutlet weak var mySegmentedControl: UISegmentedControl!
    @IBOutlet weak var mySlider: UISlider!
    @IBOutlet weak var myStepper: UIStepper!
    @IBOutlet weak var mySwith: UISwitch!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var myProgressView: UIProgressView!
    @IBOutlet weak var myStepperLabel: UILabel!
    @IBOutlet weak var mySwitchLabel: UILabel!
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myTextView: UITextView!
    
    
    // Vbles
    
    private let myPickerViewValues = ["Uno", "Dos", "Tres", "Cuatro", "Cinco"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Buttons
        
        myButton.setTitle("Mi botón", for: .normal)
        myButton.backgroundColor = .blue
        myButton.setTitleColor(.black, for: .normal)
        
        // Pickers
        
        myPickerView.backgroundColor = .lightGray
       
        // * datasource => indicar que clase proporciona los elementos
        myPickerView.dataSource = self // self = la clase ViewController
        myPickerView.delegate = self // self = la clase ViewController
        
        myPickerView.isHidden = true // Para que este apagado al iniciar (hasta que se active el switch
        
        // PageControls
        
        mypagecontrol.numberOfPages = myPickerViewValues.count
        mypagecontrol.currentPageIndicatorTintColor = .blue // color para elemento seleccionado
        mypagecontrol.pageIndicatorTintColor = .lightGray // color para elemento no seleccionado
        
        // Segmentedcontrols
        
        mySegmentedControl.removeAllSegments()
        for (index, value) in myPickerViewValues.enumerated() {
            // Accedemos a myS.insertarSegmentos (añade imagen o un texto = elementos del picker)
            mySegmentedControl.insertSegment(withTitle: value, at: index, animated: true)
        }
        
        // Sliders
        
        mySlider.minimumTrackTintColor = .red   // Color
        
        mySlider.minimumValue = 0              // Valor mínimo
        //mySlider.maximumValue = myPickerViewValues.count -> da error hay que poner Float (Fix)
        mySlider.maximumValue = Float(myPickerViewValues.count) - 1 // Valor max = nº valores que hay en el picker
        
        mySlider.value = 0.1                      // Valor por defecto
        
        mySlider.isUserInteractionEnabled = true // ???
        
        
        // Steppers
        
        myStepper.minimumValue = 1
        myStepper.maximumValue = Double(myPickerViewValues.count)

        // Switch
        
        mySwith.onTintColor = .purple
        mySwith.isOn = false // Apagado por defecto
        
        
        // Progress Indicators
        
        myProgressView.progress = 0 // valor inicial 0
        
        myActivityIndicator.startAnimating()
        myActivityIndicator.color = .magenta
        myActivityIndicator.hidesWhenStopped = true
        
        // Labels
        myStepperLabel.textColor = .darkGray
        myStepperLabel.font = UIFont.boldSystemFont(ofSize: 16)
        myStepperLabel.text = "1"
        
        mySwitchLabel.text = "OFF"
        
        // TextFields
        
        myTextField.textColor = .magenta
        myTextField.placeholder = "Escribe algo..."
        
        //myTextField.dataSource = self
        myTextField.delegate = self
        
        // TextView
        
        myTextView.textColor = .systemPurple
        // Para que no sea editable:
        // myTextView.isEditable = false
        myTextView.delegate = self
        
    }

   
    // Actions
    
    @IBAction func mybuttonAction(_ sender: Any) {
        if myButton.backgroundColor == .blue {
            myButton.backgroundColor = .magenta
        } else {
            myButton.backgroundColor = .blue
        }
        
        myTextView.resignFirstResponder() // Se cierra el teclado asociado al textView
    }
    
    @IBAction func pyPageControlAction(_ sender: Any) {
        myPickerView.selectRow(mypagecontrol.currentPage, inComponent: 0, animated: true) // 0 -> columna única/componente, contar desde 0
        
        let myStringSelected = myPickerViewValues[mypagecontrol.currentPage]
        
        // Para cambiar el nombre del boton con el valor seleccionado:
        myButton.setTitle(myStringSelected, for: .normal)
        
        // Para cambiar el valor del segmentedControl con el valor seleccionado:
        mySegmentedControl.selectedSegmentIndex = mypagecontrol.currentPage
        
        // Para cambiar el valor del slider
        let value = mypagecontrol.currentPage
        mySlider.value = Float(value)
        
        // Para cambiar el valor del progress view con el valor seleccionado:
        let selectedRow = mypagecontrol.currentPage
        let progress = Float(selectedRow) / Float(myPickerViewValues.count - 1)
        myProgressView.setProgress(progress, animated: true)
        
    }
    
    @IBAction func mySegmentedControlAction(_ sender: Any) {
        myPickerView.selectRow(mySegmentedControl.selectedSegmentIndex, inComponent: 0, animated: true)
        
        let myStringSelected = myPickerViewValues[mySegmentedControl.selectedSegmentIndex]
        
        mypagecontrol.currentPage = mySegmentedControl.selectedSegmentIndex
        // Para cambiar el nombre del boton con el valor seleccionado:
        myButton.setTitle(myStringSelected, for: .normal)
        
        // Primero accedemos al valor del seg
        let value = mySegmentedControl.selectedSegmentIndex
        mySlider.value = Float(value)
        
        // para la progressView
        let selectedValue = mySegmentedControl.selectedSegmentIndex
        let progress = Float(selectedValue) / Float(myPickerViewValues.count - 1)
        myProgressView.setProgress(progress, animated: true)
        
        
    }
    
    @IBAction func mySliderAction(_ sender: Any) {
        myPickerView.selectRow(mypagecontrol.currentPage, inComponent: 0, animated: true)
        
        let myStringSelected = myPickerViewValues[mypagecontrol.currentPage]
        
        var progress: Float = 0
        
        let value = myStepper.value
        mySlider.value = Float(value)
        
        switch mySlider.value {
        case  1..<2:
            mySegmentedControl.selectedSegmentIndex = 0
            mypagecontrol.currentPage = mySegmentedControl.selectedSegmentIndex
            // Para cambiar el nombre del boton con el valor seleccionado:
            myButton.setTitle(myStringSelected, for: .normal)
            
            progress = 0.2
            
            //updateValues()
        case  2..<3:
            mySegmentedControl.selectedSegmentIndex = 1
            mypagecontrol.currentPage = mySegmentedControl.selectedSegmentIndex
            // Para cambiar el nombre del boton con el valor seleccionado:
            myButton.setTitle(myStringSelected, for: .normal)
            
            progress = 0.4
            
            //updateValues()
 
        case  3..<4:
            mySegmentedControl.selectedSegmentIndex = 2

            mypagecontrol.currentPage = mySegmentedControl.selectedSegmentIndex
            // Para cambiar el nombre del boton con el valor seleccionado:
            myButton.setTitle(myStringSelected, for: .normal)
            
            progress = 0.6
            
            //updateValues()
            
        case  4..<5:
            mySegmentedControl.selectedSegmentIndex = 3

            mypagecontrol.currentPage = mySegmentedControl.selectedSegmentIndex
            // Para cambiar el nombre del boton con el valor seleccionado:
            myButton.setTitle(myStringSelected, for: .normal)
            
            progress = 0.8
            
            //updateValues()
           
        default:
            mySegmentedControl.selectedSegmentIndex = 4
            //myButton.setTitle(sliderValue, for: .normal)
            // Para cambiar el nombre del boton con el valor seleccionado:
            myButton.setTitle(myStringSelected, for: .normal)
            
            progress = 1
            
            break
    
        }
        
        myProgressView.progress = progress
    }
    
    @IBAction func myStepperAction(_ sender: Any) {
        // Primero accedemos al valor del stepper
        let value = myStepper.value
        mySlider.value = Float(value)
        
        // Interpolar
        myStepperLabel.text = "\(value)"
        
    }
    
    @IBAction func mySitchAction(_ sender: Any) {
        if mySwith.isOn {   // Si esta apagado esta oculto
            myPickerView.isHidden = false
            myActivityIndicator.stopAnimating()
            myActivityIndicator.isHidden = true
            mySwitchLabel.text = "ON"
        } else {
            myPickerView.isHidden = true
            myActivityIndicator.startAnimating()
            myActivityIndicator.isHidden = false
            mySwitchLabel.text = "OFF"

        }
    }
    
}

// Referencia al PickerView
// Protocolos:
// UIPickerViewDataSource -> para cargar datos en esa vista
// UIPickerViewDelegate -> para interactuar con nuestro ViewController
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    // Columnas:
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // 1 columna/componente
    }
    // Filas:
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // return 5 // nº filas/valores
        return myPickerViewValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerViewValues[row]
    }
    
    // Para cuando he seleccionado una fila:
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let myStringSelected = myPickerViewValues[row]
        // Para cambiar el nombre del boton con el valor seleccionado:
        myButton.setTitle(myStringSelected, for: .normal)
        
        // Para marcar la fila que tenemos seleccionada:
        mypagecontrol.currentPage = row
        
        // Para marcar la fila que tenemos seleccionada:
        mySegmentedControl.selectedSegmentIndex = row
        
        // Para cambiar el valor del slider con el valor seleccionado:
        mySlider.value = Float(row)

        // Para cambiar el valor del progress view con el valor seleccionado:
        let progress = Float(row) / Float(myPickerViewValues.count - 1)
        myProgressView.setProgress(progress, animated: true)
    }

}

// Referencia al TextField
extension ViewController: UITextFieldDelegate {
    // Cuando pulsemos el botón return en el teclado:
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    // cuando el textField termina su edición
    func textFieldDidEndEditing(_ textField: UITextField) {
        myButton.setTitle(textField.text, for: .normal)
    }
}

// Referencia al TextView
extension ViewController: UITextViewDelegate {
    // Cuando el textView comience a editarse:
    func textViewDidBeginEditing(_ textView: UITextView) {
        myTextField.isHidden = true
    }
    // cuando finalice la edición
    func textViewDidEndEditing(_ textView: UITextView) {
        myTextField.isHidden = false

    }
}
