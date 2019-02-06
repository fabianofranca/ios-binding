import Foundation
import UIKit

struct SampleViewModel {
    let text = Dynamic<String>("")
    let enabled = Dynamic<Bool>(true)
    let progress = Dynamic<Float>(0.0)
    
    let slider : ConverterDynamic<Float,Float>
    let stepper : ConverterDynamic<Float,Double>
    let image : ConverterDynamic<Bool, UIImage>
    let color : ConverterDynamic<Bool, UIColor>
    
    init() {
        slider = ConverterDynamic<Float,Float>(
            progress,
            set: { value in return value / 100 },
            get: { value in return value * 100 })
        
        stepper = ConverterDynamic<Float,Double>(
            slider,
            set: { value in return Float(value) },
            get: { value in return Double(value) })
        
        image = ConverterDynamic<Bool, UIImage>(enabled) { value in
            return value ? UIImage(named: "ok")!.withRenderingMode(.alwaysTemplate) : UIImage(named: "cancel")!.withRenderingMode(.alwaysTemplate)
        }

        color = ConverterDynamic<Bool, UIColor>(enabled) { value in
            return value ? UIColor.green : UIColor.red
        }
    }
    
    let openDialog = SimpleEvent()
    
    func fetch() {
        progress.value = 0.0
        enabled.value = false
        text.value = "Hello world!"
        
        openDialog.trigger()
    }
}
