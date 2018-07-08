import React from "react"
import PropTypes from "prop-types"
import { Modal,ModalManager,Effect} from 'react-dynamic-modal';


class StoryEditModal extends React.Component {
    render() {
        const { story, onRequestClose } = this.props;

        return (
            <Modal
                style={{overlay: {overflow: 'auto'}, content: {width: '50%'}}}
                onRequestClose={onRequestClose}
                effect={Effect.ScaleUp}>
                <div className="modal-header">
                    <h4 className="modal-title">Edit Story</h4>
                </div>
                <div className="modal-body">
                    asdf asdf
                </div>
                <div className="modal-footer">
                    <button className="btn btn-danger" onClick={ModalManager.close}>Close</button>
                </div>

            </Modal>
        );
    }
}

StoryEditModal.propTypes = {
    story: PropTypes.object
};
export default StoryEditModal
