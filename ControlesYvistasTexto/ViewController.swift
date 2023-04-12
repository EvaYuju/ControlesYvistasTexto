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
        myPickerView.dataSource = self // self = el mismo picker
        myPickerView.delegate = self // self = la clase ViewController
        
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
        //mySlider.maximumValue = myPickerViewValues.count -> da error hay que poner Float
        mySlider.maximumValue = Float(myPickerViewValues.count) // Valor max = nº valores que hay en el picker
        
        mySlider.value = 1                      // Valor por defecto
        
        


    }

    // Actions
    
    @IBAction func mybuttonAction(_ sender: Any) {
        if myButton.backgroundColor == .blue {
            myButton.backgroundColor = .green
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

    }
    
    @IBAction func mySegmentedControlAction(_ sender: Any) {
        myPickerView.selectRow(mySegmentedControl.selectedSegmentIndex, inComponent: 0, animated: true)
        
        let myStringSelected = myPickerViewValues[mySegmentedControl.selectedSegmentIndex]
        
        mypagecontrol.currentPage = mySegmentedControl.selectedSegmentIndex
        // Para cambiar el nombre del boton con el valor seleccionado:
        myButton.setTitle(myStringSelected, for: .normal)
    }
    
    @IBAction func mySliderAction(_ sender: Any) {
        let myStringSelected = myPickerViewValues[mySegmentedControl.selectedSegmentIndex]
        switch mySlider.value {
        case  1..<2:
            mySegmentedControl.selectedSegmentIndex = 0
        case  2..<3:
            mySegmentedControl.selectedSegmentIndex = 1
            myButton.setTitle(myStringSelected, for: .normal)
        case  3..<4:
            mySegmentedControl.selectedSegmentIndex = 2
        case  4..<5:
            mySegmentedControl.selectedSegmentIndex = 3
        default:
            mySegmentedControl.selectedSegmentIndex = 4
        }
    }
    
}

// Referencia al PickerView
// Protocolos:
// UIPickerViewDataSource -> para cargar datos en esa vista
// UIPickerViewDelegate -> para interactuar con nuestro ViewController
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // 1 columna/componente
    }
    
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

    }
    

}

