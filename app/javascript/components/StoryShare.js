import React from "react"
import PropTypes from "prop-types"
import { Modal,ModalManager,Effect} from 'react-dynamic-modal';

class ShareModal extends React.Component{
    render(){
        const { text,onRequestClose } = this.props;
        return (
            <Modal
                onRequestClose={onRequestClose}
                effect={Effect.ScaleUp}>
                <div className="modal-header">
                    <h4 className="modal-title">Share</h4>
                </div>
                <div className="modal-body">

                </div>
                <div className="modal-footer">
                    <button className="btn btn-danger" onClick={ModalManager.close}>Close</button>
                </div>

            </Modal>
        );
    }
}


class StoryShare extends React.Component {
    constructor(props) {
        super(props);

        this.story = this.props.story;
        this.user = this.story.user;
        this.currentUser = this.props.currentUser;
    }

    inspiredClicked = () => {
        this.props.handleInspired(this.story)
    }
    buttonContent = () => {
        if (this.story.current_user_inspired) {
            return (
                <span>
                    Inspired &nbsp;
                    <i className="fa fa-check-square-o"/>
                </span>
            )
        } else {
            return ("Inspired ? ")
        }
        this.props.handleInspired(this.story)
    }

    openModal = () => {
        console.log("ddddd")
        ModalManager.open(<ShareModal text={'Hello'} onRequestClose={() => true}/>);
    }

    render() {
        return (
            <div className="margin-top-30 story-share-row">
                    <div className="col-md-8 no-side-padding">
                        <button
                            className={"like-button bookmark-button-story " + (this.story.current_user_inspired ? "liked" : "")}
                            onClick={this.inspiredClicked }>
                            <span className="like-icon"
                                  item-id={this.story.id}></span>
                            {this.buttonContent()}
                        </button>
                        <span> {this.story.inspirations_count} inspired</span>
                    </div>

                    <div className="col-md-4 text-right no-side-padding">
                        <div className="share-icon">
                            <button  onClick={this.openModal}> <span className="fa fa-share-alt"></span>
                                Share
                            </button>
                        </div>
                    </div>
            </div>
        );
    }
}

StoryShare.propTypes = {
    story: PropTypes.object
};
export default StoryShare
