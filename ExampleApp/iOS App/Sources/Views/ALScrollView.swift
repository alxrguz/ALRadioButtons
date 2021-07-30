

import UIKit
import SnapKit

public class ALScrollView: UIScrollView {
    // MARK: UI Elements
    public lazy var contentView = UIView()
    public lazy var backgroundView = UIView()
    
    // MARK: Public Properties
    var orientation: NSLayoutConstraint.Axis = .vertical { didSet { remakeConstraints() } }
    
    // MARK: Lifecycle
    public init(orientation: NSLayoutConstraint.Axis = .vertical) {
        super.init(frame: .zero)
        delaysContentTouches = false
        self.orientation = orientation
        
        addSubview(backgroundView)
        addSubview(contentView)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UIControl && (view is UISwitch) == false { return true }
        return super.touchesShouldCancel(in: view)
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        remakeConstraints()
    }
    
    public func remakeConstraints() {
        guard let superview = self.superview else {  return}
        backgroundView.snp.remakeConstraints {
            $0.edges.equalTo(superview)
        }
        
        contentView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
            if orientation == .vertical {
                $0.width.equalToSuperview()
            } else {
                $0.height.equalToSuperview()
            }
        }
    }
}
