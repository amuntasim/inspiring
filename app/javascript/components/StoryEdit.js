import React from "react"
import PropTypes from "prop-types"
import { Modal,ModalManager,Effect} from 'react-dynamic-modal';
import StoryForm from './StoryForm.js';


class StoryEditModal extends React.Component {

    closeEditModal = () => {
        ModalManager.close()
    }

    render() {
        const { story, onRequestClose } = this.props;
        return (
            <Modal
                style={{overlay: {top: '-100px', overflow: 'auto'}, content: {width: '50%'}}}
                onRequestClose={onRequestClose}
                effect={Effect.ScaleUp}>

                <StoryForm story={story} closeEditModal={this.closeEditModal}
                           onStoryUpdated={this.props.onStoryUpdated}/>
            </Modal>
        );
    }
}

StoryEditModal.propTypes = {
    story: PropTypes.object
};
export default StoryEditModal
