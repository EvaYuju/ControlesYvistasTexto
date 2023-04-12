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
    
    
    // Vbles
    
    private let myPickerViewValues = ["Uno", "Dos", "Tres", "Cuatro", "Cinco"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Buttons
        
        myButton.setTitle("Mi botón", for: .normal)
        myButton.backgroundColor = .blue
        myButton.setTitleColor(.white, for: .normal)
        
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
        
        mySlider.minimumValue = 1               // Valor mínimo
        //mySlider.maximumValue = myPickerViewValues.count -> da error hay que poner Float (Fix)
        mySlider.maximumValue = Float(myPickerViewValues.count) // Valor max = nº valores que hay en el picker
        
        mySlider.value = 1                      // Valor por defecto
        
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

    }

   
    // Actions
    
    @IBAction func mybuttonAction(_ sender: Any) {
        if myButton.backgroundColor == .blue {
            myButton.backgroundColor = .yellow
        } else {
            myButton.backgroundColor = .blue
        }
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
        
    }
    
    @IBAction func mySliderAction(_ sender: Any) {
        myPickerView.selectRow(mypagecontrol.currentPage, inComponent: 0, animated: true)
        
        let myStringSelected = myPickerViewValues[mypagecontrol.currentPage]
        
        var progress: Float = 0
        
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
            
            //break
    
        }
        
        myProgressView.progress = progress
    }
    
    @IBAction func myStepperAction(_ sender: Any) {
        // Primero accedemos al valor del stepper
        let value = myStepper.value
        mySlider.value = Float(value)
    }
    
    @IBAction func mySitchAction(_ sender: Any) {
        if mySwith.isOn {   // Si esta apagado esta oculto
            myPickerView.isHidden = false
            myActivityIndicator.stopAnimating()
            myActivityIndicator.isHidden = true
        } else {
            myPickerView.isHidden = true
            myActivityIndicator.startAnimating()
            myActivityIndicator.isHidden = false
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
        
        // Slider

    }
    

}

