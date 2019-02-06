import UIKit

class SampleViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel! {
        didSet {
            label.bind().text(viewModel.text)
        }
    }
    
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.bind().text(viewModel.text, withTwoWay: true)
            textField.bind().isEnabled(viewModel.enabled)
        }
    }
    
    @IBOutlet weak var slider: UISlider! {
        didSet {
            slider.bind().value(viewModel.slider , withTwoWay: true)
        }
    }
    
    @IBOutlet weak var progress: UIProgressView! {
        didSet {
            progress.bind().progress(viewModel.progress)
        }
    }
    
    @IBOutlet weak var stepper: UIStepper! {
        didSet {
            stepper.bind().value(viewModel.stepper, withTwoWay: true)
        }
    }
    
    @IBOutlet weak var uiswitch: UISwitch! {
        didSet {
            uiswitch.bind().isOn(viewModel.enabled, withTwoWay: true)
        }
    }
    
    @IBOutlet weak var button: UIButton! {
        didSet {
            button.bind().isEnabled(viewModel.enabled)
        }
    }
    
    @IBOutlet weak var image: UIImageView! {
        didSet {
            image.bind().image(viewModel.image)
            image.bind().tintColor(viewModel.color)
        }
    }
    
    private let alertController = UIAlertController(title: nil, message: "Fetch!", preferredStyle: .alert)
    
    private var viewModel = SampleViewModel()
    
    override func viewDidLoad() {
        alertController.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] (action) in
            guard let weakSelf = self else { return }
            
            weakSelf.alertController.dismiss(animated: true, completion: nil)
        })
        
        viewModel.openDialog.subscribe { [weak self] in
            
            guard let weakSelf = self else { return }
            
            weakSelf.present(weakSelf.alertController, animated: true, completion: nil)
        }
    }

    @IBAction func fetch(_ sender: UIButton) {
        viewModel.fetch()
    }
}

